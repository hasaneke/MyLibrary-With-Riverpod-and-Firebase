import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';

class GoogleButton extends HookConsumerWidget {
  const GoogleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      elevation: 8.0,
      height: 60,
      color: Theme.of(context).backgroundColor,
      onPressed: () async {
        await ref.read(authNotifier.notifier).signInWithGoogle();
        if (ref.read(authNotifier) != null) {
          AutoRouter.of(context).replace(const TabScreen());
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Image(
              image: AssetImage('assets/google_light.png'),
              height: 35,
            ),
          ),
          SizedBox(
            width: 140,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Google Sign In',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
