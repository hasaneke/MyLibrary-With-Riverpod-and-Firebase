import 'dart:developer';

import 'package:data_service/network/data_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/data/repository/data_store/data_store_repository.dart';
import 'package:my_library/logic/providers/auth_state.dart';
import 'package:riverpod/riverpod.dart';

final dataStoreRepository =
    StateProvider.autoDispose<DataStoreRepository>((ref) {
  final dataService = DataService();
  dataService.initService(ref.read(authStateProvider)!.uid);
  return DataStoreRepository(dataService: dataService);
});
final categoriesNotifier = StateNotifierProvider.autoDispose<CategoriesNotifier,
    AsyncValue<List<MyCategory>>>((ref) {
  return CategoriesNotifier(ref.read);
});

final mainCategoriesProvider = Provider.autoDispose<List<MyCategory>>((ref) {
  List<MyCategory> mainCategories = [];
  ref.watch(categoriesNotifier).whenData((categories) {
    mainCategories = categories
        .where((category) => category.containerCatId == null)
        .toList();
    for (var category in mainCategories) {
      log(category.title!);
    }
  });
  return mainCategories;
});

final allCategoriesProvider = Provider.autoDispose<List<MyCategory>>((ref) {
  List<MyCategory> allCategories = [];
  ref.watch(categoriesNotifier).whenData((categories) {
    allCategories = categories;
  });
  return allCategories;
});

class CategoriesNotifier extends StateNotifier<AsyncValue<List<MyCategory>>> {
  CategoriesNotifier(this.read, [AsyncValue<List<MyCategory>>? state])
      : super(state ?? const AsyncLoading()) {
    fetchCategories();
  }
  Reader read;
  Future<void> fetchCategories() async {
    try {
      state = AsyncData(await read(dataStoreRepository).fetchCategories());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> addCategory({required MyCategory myCategory}) async {
    await read(dataStoreRepository).addCategory(myCategory: myCategory);
    state = state.whenData((categories) => [...categories, myCategory]);
  }

  Future<void> updateCategory({required MyCategory myCategory}) async {
    await read(dataStoreRepository).updateCategory(myCategory: myCategory);
    state = state.whenData((categories) => categories.map((category) {
          if (category.uniqueId == myCategory.uniqueId) {
            return myCategory;
          } else {
            return category;
          }
        }).toList());
  }

  Future<void> deleteCategory({required String id}) async {
    await read(dataStoreRepository).deleteCategory(id: id);
    state = state.whenData((categories) =>
        categories.where((element) => element.uniqueId != id).toList());
  }
}
