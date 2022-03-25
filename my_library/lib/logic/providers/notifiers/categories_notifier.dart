// ignore_for_file: unused_import

import 'dart:developer';

import 'package:data_service/exceptions/data_exception.dart';
import 'package:data_service/network/firestore_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/data/repository/data_store/data_store_repository.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';
import 'package:riverpod/riverpod.dart';

final dataStoreRepository =
    StateProvider.autoDispose<DataStoreRepository>((ref) {
  final dataService = DataService();
  dataService.initService(ref.read(authNotifier)!.uid);
  return DataStoreRepository(dataService: dataService);
});
final categoriesNotifier = StateNotifierProvider.autoDispose<CategoriesNotifier,
    AsyncValue<List<MyCategory>>>((ref) {
  return CategoriesNotifier(ref.read);
});

class CategoriesNotifier extends StateNotifier<AsyncValue<List<MyCategory>>> {
  CategoriesNotifier(this.read, [AsyncValue<List<MyCategory>>? state])
      : super(state ?? const AsyncLoading()) {
    fetchCategories();
    read(cardsNotifier.notifier).fetchCards();
  }
  Reader read;
  List<MyCategory> _allCategories = [];
  Future<void> fetchCategories() async {
    try {
      log('Fetched!');
      var fetchedCategories = await read(dataStoreRepository).fetchCategories();
      state = AsyncData(fetchedCategories);
      _allCategories = fetchedCategories;
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> addCategory({required MyCategory myCategory}) async {
    try {
      if (myCategory.containerCatId != null) {
        final containerCategory = state.value!.firstWhere(
            (element) => element.uniqueId == myCategory.containerCatId);

        updateCategory(
            myCategory: containerCategory.copyWith(subCategoriesIds: [
          ...?containerCategory.subCategoriesIds,
          myCategory.uniqueId
        ]));
      }
      state = state.whenData((categories) => [...categories, myCategory]);
      await read(dataStoreRepository).addCategory(myCategory: myCategory);

      _allCategories = [..._allCategories, myCategory];
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> updateCategory({required MyCategory myCategory}) async {
    try {
      await read(dataStoreRepository).updateCategory(myCategory: myCategory);
      state = state.whenData((categories) => categories.map((category) {
            if (category.uniqueId == myCategory.uniqueId) {
              return myCategory;
            } else {
              return category;
            }
          }).toList());
      _allCategories = _allCategories.map((category) {
        if (category.uniqueId == myCategory.uniqueId) {
          return myCategory;
        } else {
          return category;
        }
      }).toList();
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> deleteCategory({required MyCategory myCategory}) async {
    if (myCategory.subCategoriesIds!.isNotEmpty) {
      await _deleteSubCategories(myCategory: myCategory);
    }
    if (myCategory.cardsIds!.isNotEmpty) {
      await _clearCards(cardIds: myCategory.cardsIds!);
    }
    await read(dataStoreRepository).deleteCategory(id: myCategory.uniqueId);

    state = state.whenData((data) => data
        .where((element) => element.uniqueId != myCategory.uniqueId)
        .toList());
  }

  Future<void> _deleteSubCategories({required MyCategory myCategory}) async {
    for (var subCatId in myCategory.subCategoriesIds!) {
      final category =
          _allCategories.firstWhere((element) => element.uniqueId == subCatId);
      await _clearCards(cardIds: category.cardsIds!);
      await _deleteSubCategories(myCategory: category);
    }
    await read(dataStoreRepository).deleteCategory(id: myCategory.uniqueId);
  }

  Future<void> _clearCards({required List<String> cardIds}) async {
    List<MyCard> cards = read(allCardsProvider)
        .where((element) => cardIds.contains(element.id))
        .toList();
    for (var card in cards) {
      for (var imageUrl in card.imageUrls!) {
        await read(storageRepository).deleteFile(url: imageUrl);
      }
      await read(dataStoreRepository).deleteCard(id: card.id);
    }
  }

  @override
  void dispose() {
    log('disposed!');
    super.dispose();
  }
}
