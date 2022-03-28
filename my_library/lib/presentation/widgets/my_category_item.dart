import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/navigation/route.gr.dart';

// ignore: must_be_immutable
class MyCategoryItem extends StatelessWidget {
  MyCategory myCategory;
  Function longPressed;
  // ignore: use_key_in_widget_constructors
  MyCategoryItem({
    required this.myCategory,
    required this.longPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AutoRouter.of(context)
            .push(CategoryDetailScreen(myCategory: myCategory));
      },
      child: Container(
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
                  color: Color(myCategory.colorCode!) == const Color(0xcc0f0c08)
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )),
    );
  }
}
