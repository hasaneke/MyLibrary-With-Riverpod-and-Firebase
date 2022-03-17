import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';

final myDrawerController = StateNotifierProvider((ref) {
  return MyDrawerController(ref.read);
});

enum DrawerOptions {
  signout,
}

class MyDrawerController extends StateNotifier {
  MyDrawerController(this.read, [state]) : super(state);
  Reader read;

  Future<void> onSelectedOption(
      {required DrawerOptions option, required BuildContext context}) async {
    switch (option) {
      case DrawerOptions.signout:
        read(cardsNotifier.notifier).mounted
            ? null
            : read(cardsNotifier.notifier).dispose();
        read(categoriesNotifier.notifier).dispose();
        await read(authNotifier.notifier).logOut();
    }
  }
}
