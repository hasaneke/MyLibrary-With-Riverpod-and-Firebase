import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myAppBarController = ChangeNotifierProvider<MyAppbarController>((ref) {
  return MyAppbarController();
});

class MyAppbarController extends ChangeNotifier {
  bool isAnyItemLongPressed = false;
  List<String> _selectedCards = [];
  List<String> _selectedCategories = [];

  List<String> get selectedCards => _selectedCards;
  List<String> get selectedCategories => _selectedCategories;

  void changeAppbar() {
    log('??');
    log(isAnyItemLongPressed.toString());
    isAnyItemLongPressed = !isAnyItemLongPressed;
    _selectedCards.clear();
    _selectedCategories.clear();
    notifyListeners();
  }

  void addToSelectedCards({required String uniqueId}) {
    _selectedCards = [..._selectedCards, uniqueId];
    print(_selectedCards);
  }

  void removeFromSelectedCards({required String uniqueId}) {
    _selectedCards.remove(uniqueId);
  }

  void addToSelectedCategories({required String uniqueId}) {
    _selectedCategories = [..._selectedCategories, uniqueId];
    print(_selectedCategories);
  }

  void removeFromSelectedCategories({required String uniqueId}) {
    _selectedCategories.remove(uniqueId);
  }
}
