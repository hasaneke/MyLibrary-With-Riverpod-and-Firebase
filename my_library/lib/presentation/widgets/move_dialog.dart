import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_library/logic/providers/state_providers/data_providers.dart';

class MoveDialog extends HookConsumerWidget {
  final String uniqueId;
  const MoveDialog({
    Key? key,
    required this.uniqueId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainCategory = ref
        .read(allCategoriesProvider)
        .where((cat) => cat.containerCatId == null);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      elevation: 7,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: mainCategory
              .map((e) => ListTile(
                    title: Text(e.title!),
                    tileColor: Color(e.colorCode!),
                    onTap: () {},
                  ))
              .toList()),
    );
  }
}
