import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'my_category_item.dart';

// ignore: must_be_immutable
class MyCategoryGridView extends HookConsumerWidget {
  String? containerCatId;
  // ignore: use_key_in_widget_constructors
  MyCategoryGridView({this.containerCatId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref
        .watch(allCategoriesProvider)
        .where((element) => element.containerCatId == containerCatId);
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
        itemCount: convertedToWidgetsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 45,
            mainAxisSpacing: 45,
            crossAxisCount: 3,
            childAspectRatio: 1),
      ),
    );
  }
}
