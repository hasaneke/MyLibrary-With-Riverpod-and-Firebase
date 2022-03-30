import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/presentation/widgets/move_dialog/move_dialog.dart';
import 'package:my_library/presentation/widgets/my_app_bar/controller/my_app_bar_controller.dart';

class MyAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;

  const MyAppBar({
    Key? key,
    this.title,
    this.actions,
    this.centerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final isAnyItemLongPressed = ref.watch(
            myAppBarController.select((value) => value.isAnyItemLongPressed));
        final controller = ref.read(myAppBarController);
        return WillPopScope(
            child: isAnyItemLongPressed
                ? AppBar(
                    foregroundColor:
                        Theme.of(context).appBarTheme.foregroundColor,
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    elevation: 0,
                    title: const Text('1 selected'),
                    leading: Radio(
                      value: 1,
                      groupValue: -1,
                      onChanged: (value) {},
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => MoveDialog());
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 25),
                            IconButton(
                              onPressed: () {
                                controller.deleteTheItems();
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : AppBar(
                    foregroundColor:
                        Theme.of(context).appBarTheme.foregroundColor,
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    elevation: 0,
                    title: title,
                    centerTitle: centerTitle,
                    actions: actions,
                  ),
            onWillPop: () async {
              if (ref.read(myAppBarController.notifier).isAnyItemLongPressed ==
                  true) {
                ref.read(myAppBarController).changeAppbar();
              } else {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              }
              return false;
            });
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
