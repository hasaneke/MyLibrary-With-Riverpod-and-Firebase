import 'package:flutter/material.dart';
import 'package:my_library/data/models/my_category.dart';

import 'my_category_item.dart';

// ignore: must_be_immutable
class MyCategoryGridView extends StatelessWidget {
  List<MyCategory> categories;
  // ignore: use_key_in_widget_constructors
  MyCategoryGridView(this.categories);
  @override
  Widget build(BuildContext context) {
    List<MyCategoryItem> convertedToWidgetsList = categories.map((category) {
      return MyCategoryItem(category);
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GridView.builder(
        itemBuilder: (BuildContext context, index) {
          return convertedToWidgetsList[index];
        },
        controller: ScrollController(keepScrollOffset: true),
        shrinkWrap: true,
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 35,
            mainAxisSpacing: 35,
            crossAxisCount: 3,
            childAspectRatio: 1),
      ),
    );
  }
}
