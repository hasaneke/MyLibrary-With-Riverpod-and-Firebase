import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/presentation/widgets/add_category_dialog.dart';

class HomeAppBar extends HookConsumerWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: Center(
        child: SizedBox(
            height: 45, width: 45, child: Image.asset('assets/icon_white.png')),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add_to_photos_outlined,
            size: 30,
          ),
          onPressed: () {
            showDialog(context: context, builder: (_) => AddCategoryDialog());
          },
        ),
      ],
    );
  }
}
