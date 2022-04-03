import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';

final myAppBarController = ChangeNotifierProvider<MyAppbarController>((ref) {
  return MyAppbarController(ref.read);
});

class MyAppbarController extends ChangeNotifier {
  Reader read;
  MyAppbarController(this.read);
  bool isAnyItemLongPressed = false;

  List<MyCard> _selectedCards = [];
  List<MyCategory> _selectedCategories = [];

  List<MyCategory> get selectedCategories => _selectedCategories;
  List<MyCard> get selectedCards => _selectedCards;

  void changeAppbar() {
    isAnyItemLongPressed = !isAnyItemLongPressed;
    _selectedCards.clear();
    _selectedCategories.clear();
    notifyListeners();
  }

  void putInSelectedCardsList({required MyCard card}) {
    if (!_selectedCards.contains(card)) {
      _selectedCards = [..._selectedCards, card];
    } else {
      _selectedCards =
          _selectedCards.where((element) => element.id != card.id).toList();
    }
    notifyListeners();
  }

  void putInSelectedCategoriesList({required MyCategory category}) {
    if (!_selectedCategories.contains(category)) {
      _selectedCategories = [..._selectedCategories, category];
    } else {
      _selectedCategories = _selectedCategories
          .where((element) => element.uniqueId != category.uniqueId)
          .toList();
    }
    notifyListeners();
  }

  void selectAll() {}

  Future<void> deleteTheItems() async {
    for (var cat in _selectedCategories) {
      await read(categoriesNotifier.notifier).deleteCategory(myCategory: cat);
    }
    for (var card in _selectedCards) {
      await read(cardsNotifier.notifier).deleteCard(myCard: card);
    }
    changeAppbar();
    notifyListeners();
  }

  Future<void> moveTo({required MyCategory category}) async {
    for (var cat in selectedCategories) {
      read(categoriesNotifier.notifier).updateCategory(
          myCategory: cat.copyWith(containerCatId: category.uniqueId));
    }
    for (var card in selectedCards) {
      read(cardsNotifier.notifier).updateCard(
          updatedCard: card.copyWith(containerCatId: category.uniqueId));
    }
    changeAppbar();
    notifyListeners();
  }
}
