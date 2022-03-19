// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/core/constants/pop_up_menu_constants.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/presentation/home/my_category_detail_page/components/app_bar/controller/category_detail_appbar_controller.dart';
import 'package:my_library/presentation/widgets/add_category_dialog.dart';

class CategoryDetailAppbar extends HookConsumerWidget {
  MyCategory myCategory;
  CategoryDetailAppbar(this.myCategory);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(categoryDetailAppBarController);
    return AppBar(
      title: Center(
        child: Text(
          myCategory.title!,
        ),
      ),
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
