// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/core/constants/pop_up_menu_constants.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/presentation/home/my_category_detail_page/components/app_bar/controller/category_detail_appbar_controller.dart';
import 'package:my_library/presentation/widgets/add_category_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryDetailAppbar extends HookConsumerWidget {
  MyCategory myCategory;
  CategoryDetailAppbar(this.myCategory);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryDetailAppBarController =
        ChangeNotifierProvider.autoDispose<CategoryDetailAppBarController>(
            (ref) {
      return CategoryDetailAppBarController(ref.read);
    });
    final controller = ref.read(categoryDetailAppBarController);
    final textEditingController =
        useTextEditingController(text: myCategory.title);
    return AppBar(
      title: Center(child: Consumer(
        builder: (context, ref, child) {
          final editTitle = ref.watch(categoryDetailAppBarController).editTitle;
          return Center(
              child: editTitle
                  ? TextField(
                      controller: textEditingController,
                      onSubmitted: (text) {
                        controller.updateTitle(newTitle: text);
                      })
                  : Text(myCategory.title!));
        },
      )),
      foregroundColor: Colors.black,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => {
            showDialog(
                context: context,
                builder: (_) =>
                    AddCategoryDialog(containerCatId: myCategory.uniqueId))
          },
          icon: Icon(
            Icons.add_to_photos_outlined,
            color: Theme.of(context).iconTheme.color,
            size: 30,
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (choice) async {
            switch (choice) {
              case 'delete':
                await controller.deleteTheCategory(myCategory: myCategory);
                AutoRouter.of(context).pop();
                break;
              case 'edit':
                await controller.toggleEditTitle();
                break;
            }
          },
          itemBuilder: (context) => PopUpMenuConstants.choices
              .map((choice) =>
                  PopupMenuItem<String>(value: choice, child: Text(choice)))
              .toList(),
        )
      ],
    );
  }
}
