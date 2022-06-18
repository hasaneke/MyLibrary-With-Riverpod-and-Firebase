import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/product/models/my_card.dart';
import 'package:my_library/product/models/my_category.dart';

final myCardDetailScreenController = ChangeNotifierProvider.autoDispose
    .family<CategoryDetailScreenController, MyCategory>((ref, myCat) {
  return CategoryDetailScreenController(read: ref.read, myCategory: myCat);
});

class CategoryDetailScreenController extends ChangeNotifier {
  MyCategory myCategory;
  Reader read;

  CategoryDetailScreenController(
      {required this.myCategory, required this.read}) {
    cards = read(allCardsProvider)
        .where((card) => card.containerCatId == myCategory.uniqueId)
        .toList();
    categories = read(allCategoriesProvider)
        .where((cat) => cat.containerCatId == myCategory.uniqueId)
        .toList();
  }
  List<MyCard> cards = [];
  List<MyCategory> categories = [];
}
