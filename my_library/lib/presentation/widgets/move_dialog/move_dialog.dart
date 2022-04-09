import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/presentation/widgets/my_app_bar/controller/my_app_bar_controller.dart';

class MoveDialog extends HookConsumerWidget {
  const MoveDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainCategory = ref
        .read(allCategoriesProvider)
        .where((cat) => cat.containerCatId == null);
    return AlertDialog(
      title: const Text('Select destination category',
          style: TextStyle(
            fontSize: 25,
          )),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      elevation: 7,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: mainCategory
                .map((e) => Column(
                      children: [
                        catItem(e, ref.read, context),
                      ],
                    ))
                .toList()),
      ),
    );
  }

  GestureDetector catItem(
      MyCategory category, Reader read, BuildContext context) {
    return GestureDetector(
        onTap: () {
          read(myAppBarController).moveTo(id: category.uniqueId);

          AutoRouter.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 55,
          child: Row(
            children: [
              const Icon(Icons.arrow_right),
              Container(
                width: 15,
                height: 15,
                color: Color(category.colorCode!),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                category.title!,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
