import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';

final categoryDetailAppBarController =
    ChangeNotifierProvider<CategoryDetailAppBarController>((ref) {
  return CategoryDetailAppBarController(ref.read);
});

class CategoryDetailAppBarController extends ChangeNotifier {
  Reader read;
  CategoryDetailAppBarController(this.read);

  Future<void> deleteTheCategory({required MyCategory myCategory}) async {
    await read(categoriesNotifier.notifier)
        .deleteCategory(myCategory: myCategory);
  }
}
