import 'dart:developer';

import 'package:data_service/exceptions/data_exception.dart';
import 'package:data_service/network/firestore_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/data/repository/data_store/data_store_repository.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
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
  }
  Reader read;
  Future<void> fetchCategories() async {
    try {
      state = AsyncData(await read(dataStoreRepository).fetchCategories());
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> addCategory({required MyCategory myCategory}) async {
    try {
      await read(dataStoreRepository).addCategory(myCategory: myCategory);
      state = state.whenData((categories) => [...categories, myCategory]);
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
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }

  Future<void> deleteCategory({required String id}) async {
    try {
      await read(dataStoreRepository).deleteCategory(id: id);
      state = state.whenData((categories) =>
          categories.where((element) => element.uniqueId != id).toList());
    } on Exception catch (e) {
      read(dataExceptionProvider.notifier).state =
          DataException(message: e.toString());
    }
  }
}
