// ignore: unused_import
import 'dart:developer';

import 'package:data_service/network/firestore_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/data/repository/data_store/data_store_repository.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';

final dataStoreRepository =
    StateProvider.autoDispose<DataStoreRepository>((ref) {
  final dataService = DataService();
  dataService.initService(ref.read(authNotifier)!.uid);
  return DataStoreRepository(dataService: dataService);
});
final markedCardsProvider = Provider<List<MyCard>>((ref) {
  List<MyCard> favoriteCards = ref
      .watch(allCardsProvider)
      .where((card) => card.isMarked == true)
      .toList();
  return favoriteCards;
});
final allCardsProvider = Provider<List<MyCard>>((ref) {
  List<MyCard> allCards = [];
  ref.watch(cardsNotifier).whenData((cards) {
    allCards = cards;
  });
  return allCards;
});

final allCategoriesProvider =
    StateProvider.autoDispose<List<MyCategory>>((ref) {
  List<MyCategory> allCategories = [];
  ref.watch(categoriesNotifier).whenData((categories) {
    allCategories = categories;
  });
  return allCategories;
});
