import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/home/tab_bar_page/home_page/widgets/drawer/controller/my_drawer_controller.dart';

class MyDrawer extends HookConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20,
                    height: 1,
                    color: Colors.black,
                  ),
                  const Text(
                    'My Library',
                    style: TextStyle(fontSize: 27),
                  ),
                  Container(
                    width: 20,
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              ))),
          drawerItem(
              title: 'Signout',
              icon: const Icon(Icons.logout),
              option: DrawerOptions.signout,
              context: context,
              ref: ref)
        ],
      ),
    );
  }

  ListTile drawerItem({
    required String title,
    required Icon icon,
    required DrawerOptions option,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () async {
        switch (option) {
          case DrawerOptions.signout:
            await ref
                .read(myDrawerController.notifier)
                .onSelectedOption(option: option, context: context);
            AutoRouter.of(context).navigate(const LoginScreen());
        }
      },
    );
  }
}
