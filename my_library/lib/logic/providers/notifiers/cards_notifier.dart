import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:data_service/exceptions/data_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/repository/storage/storage_repository.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:storage_service/network/storage_service.dart';

final cardsNotifier =
    StateNotifierProvider<CardsNotifier, AsyncValue<List<MyCard>>>((ref) {
  return CardsNotifier(ref.read);
});
final storageRepository = StateProvider.autoDispose<StorageRepository>((ref) {
  final storageService = StorageService();
  storageService.initService(ref.read(authNotifier)!.uid);
  return StorageRepository(storageService: storageService);
});

class CardsNotifier extends StateNotifier<AsyncValue<List<MyCard>>> {
  Reader read;

  CardsNotifier(this.read, [AsyncValue<List<MyCard>>? state])
      : super(state ?? const AsyncLoading()) {
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      log('cards fetched');
      List<MyCard> cards = await read(dataStoreRepository).fetchCards();
      state = AsyncValue.data(cards);
    } on Exception catch (e) {
      state = AsyncError(e);
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> addCard(
      {required Map<String, String> values, List<File>? imageFiles}) async {
    try {
      final containerCategory = read(allCategoriesProvider).firstWhere(
          (element) => element.uniqueId == values['containerCatId']);
      await read(categoriesNotifier.notifier).updateCategory(
          myCategory: containerCategory.copyWith(
              cardsIds: [...?containerCategory.cardsIds, values['id']!]));
      List<String> imageUrls = await read(storageRepository)
          .uploadFilesAndGetTheUrls(files: imageFiles!);
      log(values['id']!);
      final newCard = MyCard.create(
          id: values['id']!,
          containerCatId: values['containerCatId']!,
          title: values['title'],
          shortExp: values['shortExp'],
          longExp: values['longExp'],
          imageUrls: imageUrls);
      await read(dataStoreRepository).addCard(myCard: newCard);
      state = state.whenData((cards) => [...cards, newCard]);
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> updateCard({required MyCard updatedCard}) async {
    try {
      await read(dataStoreRepository).updateCard(myCard: updatedCard);
      state = state.whenData((cards) => cards.map((card) {
            if (card.id == updatedCard.id) {
              return updatedCard;
            }
            return card;
          }).toList());
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> deleteCard({required String id}) async {
    try {
      final containerCategory = read(allCategoriesProvider)
          .firstWhere((element) => element.subCategoriesIds!.contains(id));

      final card =
          read(allCardsProvider).firstWhere((element) => element.id == id);
      for (var imageUrl in card.imageUrls!) {
        await read(storageRepository).deleteFile(url: imageUrl);
      }
      await read(dataStoreRepository).updateCategory(
          myCategory: containerCategory.copyWith(
              subCategoriesIds: containerCategory.subCategoriesIds!
                  .where((element) => element != id)
                  .toList()));
      await read(dataStoreRepository).deleteCard(id: id);
      state = state.whenData(
          (cards) => cards.where((element) => element.id != id).toList());
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    log('cards disposed!');
    super.dispose();
  }
}
