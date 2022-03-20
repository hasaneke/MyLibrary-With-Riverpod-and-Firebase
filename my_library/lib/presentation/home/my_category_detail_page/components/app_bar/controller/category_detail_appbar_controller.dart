import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';

class CategoryDetailAppBarController extends ChangeNotifier {
  Reader read;
  CategoryDetailAppBarController(this.read);
  bool editTitle = false;
  Future<void> deleteTheCategory({required MyCategory myCategory}) async {
    await read(categoriesNotifier.notifier)
        .deleteCategory(myCategory: myCategory);
  }

  Future<void> toggleEditTitle() async {
    editTitle = true;
    notifyListeners();
  }

  Future<void> updateTitle({required String newTitle}) async {}
}
