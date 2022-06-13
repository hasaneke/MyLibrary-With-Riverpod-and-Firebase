import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/product/widgets/drawer/controller/my_drawer_controller.dart';

class MyDrawer extends HookConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
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
                  Text(
                    'My Library',
                    style: TextStyle(
                        fontSize: 27,
                        color: Theme.of(context).textTheme.bodyText1!.color),
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
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).iconTheme.color,
              ),
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
            AutoRouter.of(context).replace(const LoginScreen());
        }
      },
    );
  }
}
