import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/widgets/my_app_bar/controller/my_app_bar_controller.dart';

// ignore: must_be_immutable
class MyCategoryItem extends StatefulHookConsumerWidget {
  MyCategory myCategory;
  MyCategoryItem({required this.myCategory});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCategoryItemState();
}

class _MyCategoryItemState extends ConsumerState<MyCategoryItem> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isAnyItemLongPressed = ref.watch(
            myAppBarController.select((value) => value.isAnyItemLongPressed));
        return GestureDetector(
          onTap: () async {
            if (isAnyItemLongPressed) {
              setState(() {
                if (_isSelected == false) {
                  ref.read(myAppBarController.notifier).addToSelectedCategories(
                      uniqueId: widget.myCategory.uniqueId);
                }
                _isSelected = !_isSelected;
              });
            } else {
              AutoRouter.of(context)
                  .push(CategoryDetailScreen(myCategory: widget.myCategory));
            }
          },
          onLongPress: () {
            setState(() {
              _isSelected = !_isSelected;
              isAnyItemLongPressed
                  ? null
                  : ref.read(myAppBarController.notifier).changeAppbar();
            });
          },
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: widget.myCategory.colorCode == null
                          ? Colors.red
                          : Color(widget.myCategory.colorCode!)),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: Text(
                        widget.myCategory.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(widget.myCategory.colorCode!) ==
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
                          value: _isSelected,
                          onChanged: (value) {
                            setState(() {
                              _isSelected = value!;
                            });
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
          ),
        );
      },
    );
  }
}
