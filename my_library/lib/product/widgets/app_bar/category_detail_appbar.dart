import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/core/constants/pop_up_menu_constants.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/presentation/widgets/add_category_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_library/presentation/widgets/my_app_bar/my_app_bar.dart';
import 'package:my_library/product/widgets/app_bar/controller/category_detail_appbar_controller.dart';

class CategoryDetailAppbar extends HookConsumerWidget {
  final MyCategory myCategory;

  const CategoryDetailAppbar({required this.myCategory, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryDetailAppBarController =
        ChangeNotifierProvider.autoDispose<CategoryDetailAppBarController>(
            (ref) {
      return CategoryDetailAppBarController(ref.read);
    });
    final controller = ref.read(categoryDetailAppBarController);
    final textEditingController =
        useTextEditingController(text: myCategory.title!);
    return MyAppBar(
      title: Center(child: Consumer(
        builder: (context, ref, child) {
          final editTitle = ref.watch(categoryDetailAppBarController).editTitle;
          return Center(
              child: editTitle
                  ? Stack(
                      children: [
                        TextField(
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2))),
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: textEditingController,
                          onChanged: (value) {
                            textEditingController.text = value;
                          },
                        ),
                        Positioned(
                          child: IconButton(
                            onPressed: () {
                              controller.updateTitle(
                                  myCategory: myCategory.copyWith(
                                      title: textEditingController.text));
                              controller.toggleEditTitle();
                            },
                            icon: const Icon(
                              Icons.check,
                              size: 15,
                            ),
                          ),
                          right: 0,
                        )
                      ],
                    )
                  : Text(myCategory.title!));
        },
      )),
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
          color: Theme.of(context).popupMenuTheme.color,
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
              .map((choice) => PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: Theme.of(context).popupMenuTheme.textStyle,
                  )))
              .toList(),
        )
      ],
    );
  }
}
