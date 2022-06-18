// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';
import 'package:my_library/product/models/my_category.dart';
import 'package:my_library/product/widgets/move_dialog/constants/custom_colors.dart';
import 'package:uuid/uuid.dart';

class AddCategoryDialog extends HookConsumerWidget {
  String? containerCatId;
  AddCategoryDialog({Key? key, this.containerCatId}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    String? title;
    Color selectedColor = Colors.black;
    return AlertDialog(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color!),
              decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              onSaved: (value) {
                title = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'empty';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              height: 120,
              child: BlockPicker(
                availableColors: Palette.colorButtons.values.toList(),
                pickerColor: Colors.black,
                onColorChanged: (color) {
                  selectedColor = color;
                },
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () async {
                      formKey.currentState!.save();
                      ref.read(categoriesNotifier.notifier).addCategory(
                          myCategory: MyCategory.create(
                              uniqueId: const Uuid().v1(),
                              containerCatId: containerCatId,
                              title: title,
                              colorCode: selectedColor.value));
                      AutoRouter.of(context).pop();
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                          fontSize: 18),
                    ))),
          ],
        ),
      ),
    );
  }
}
