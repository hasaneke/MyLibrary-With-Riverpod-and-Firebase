import 'package:flutter/material.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/presentation/widgets/my_category_gridview.dart';

class CategoriesBody extends StatefulWidget {
  const CategoriesBody({
    Key? key,
    required this.myCategory,
  }) : super(key: key);

  final MyCategory myCategory;

  @override
  State<CategoriesBody> createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends State<CategoriesBody> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return isClicked
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 9),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black54, width: 2)),
              child: Column(
                children: [
                  MyCategoryGridView(
                      containerCatId: widget.myCategory.uniqueId),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isClicked = false;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.black54,
                      ))
                ],
              ),
            ),
          )
        : IconButton(
            onPressed: () {
              setState(() {
                isClicked = true;
              });
            },
            icon: const Icon(Icons.grid_view));
  }
}
