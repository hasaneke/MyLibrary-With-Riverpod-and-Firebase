import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';

final favoriteCardsProvider = Provider<List<MyCard>>((ref) {
  List<MyCard> favoriteCards = ref
      .watch(allCardsProvider)
      .where((card) => card.isFavorite == true)
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

final allCategoriesProvider = Provider<List<MyCategory>>((ref) {
  List<MyCategory> allCategories = [];
  ref.watch(categoriesNotifier).whenData((categories) {
    allCategories = categories;
  });
  return allCategories;
});
