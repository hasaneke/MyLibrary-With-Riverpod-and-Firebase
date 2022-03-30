import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/widgets/my_app_bar/controller/my_app_bar_controller.dart';

// ignore: must_be_immutable

class MyCategoryItem extends HookConsumerWidget {
  final MyCategory myCategory;
  const MyCategoryItem({Key? key, required this.myCategory}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final isAnyItemLongPressed = ref.watch(
            myAppBarController.select((value) => value.isAnyItemLongPressed));
        final isSelected = ref.watch(myAppBarController
            .select((value) => value.selectedCategories.contains(myCategory)));
        final controller = ref.read(myAppBarController);
        return GestureDetector(onTap: () async {
          if (isAnyItemLongPressed) {
            controller.putInSelectedCategoriesList(category: myCategory);
          } else {
            AutoRouter.of(context)
                .push(CategoryDetailScreen(myCategory: myCategory));
          }
        }, onLongPress: () {
          if (isAnyItemLongPressed) {
            controller.putInSelectedCategoriesList(category: myCategory);
          } else {
            controller.changeAppbar();
            controller.putInSelectedCategoriesList(category: myCategory);
          }
        }, child: Consumer(
          builder: (context, ref, child) {
            return Opacity(
                opacity: isSelected ? 0.5 : 1,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: myCategory.colorCode == null
                                ? Colors.red
                                : Color(myCategory.colorCode!)),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Center(
                            child: Text(
                              myCategory.title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(myCategory.colorCode!) ==
                                        const Color(0xcc0f0c08)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )),
                    isAnyItemLongPressed
                        ? Positioned(
                            child: Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  controller.putInSelectedCategoriesList(
                                      category: myCategory);
                                },
                                shape: const CircleBorder(
                                    side: BorderSide(
                                  color: Colors.black,
                                ))),
                            top: 0,
                            left: 0,
                          )
                        : Container()
                  ],
                ));
          },
        ));
      },
    );
  }
}
