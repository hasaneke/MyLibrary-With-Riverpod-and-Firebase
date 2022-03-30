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
  List<MyCategory> _controlCatList = [];
  List<MyCard> _controlCardList = [];
  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await read(dataStoreRepository).fetchCategories();
      state = AsyncData(fetchedCategories);
      _controlCatList = fetchedCategories;
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> addCategory({required MyCategory myCategory}) async {
    try {
      state = state.whenData((categories) => [...categories, myCategory]);
      _controlCatList = state.asData!.value;

      await read(dataStoreRepository).addCategory(myCategory: myCategory);
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
      _controlCatList = state.asData!.value;
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> deleteCategory({required MyCategory myCategory}) async {
    _controlCardList = read(cardsNotifier.notifier).state.value!;
    await _recrusiveDeletion(myCategory: myCategory);

    state = AsyncData(_controlCatList);
  }

  Future<void> _recrusiveDeletion({required MyCategory myCategory}) async {
    List<MyCategory> _subCats = _controlCatList
        .where((subCat) => subCat.containerCatId == myCategory.uniqueId)
        .toList();
    for (var subCat in _subCats) {
      _recrusiveDeletion(myCategory: subCat);
    }

    await _clearCards(containerCatId: myCategory.uniqueId);
    await read(dataStoreRepository).deleteCategory(id: myCategory.uniqueId);
    _controlCatList.remove(myCategory);
  }

  Future<void> _clearCards({required String containerCatId}) async {
    final cardsToDelete = _controlCardList
        .where((element) => element.containerCatId == containerCatId)
        .toList();
    for (var card in cardsToDelete) {
      read(cardsNotifier.notifier).deleteCard(myCard: card);
    }
  }

  @override
  void dispose() {
    log('disposed!');
    super.dispose();
  }
}
