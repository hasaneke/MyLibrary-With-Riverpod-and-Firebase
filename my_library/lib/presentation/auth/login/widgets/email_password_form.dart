import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
import 'package:my_library/presentation/auth/login/controller/login_screen_controller.dart';

class EmailPasswordForm extends HookConsumerWidget {
  const EmailPasswordForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _focuseNode1 = FocusNode();
    final _focuseNode2 = FocusNode();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                focusNode: _focuseNode1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'email',
                    prefixIcon: Icon(Icons.mail,
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                validator: (value) {
                  if (!value!.contains('@') || value.isEmpty) {}
                  return null;
                },
                onSaved: (emailText) {},
              ),
              const Divider(),
              TextFormField(
                focusNode: _focuseNode2,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  prefixIcon: Icon(Icons.vpn_key,
                      color: Theme.of(context).iconTheme.color),
                ),
                onSaved: (passwordText) {},
                validator: (value) {
                  if (value!.isEmpty) {}
                  return null;
                },
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Not registered yet?',
              style: TextStyle(fontSize: 15),
            ),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).navigate(const SignUpScreen());
              },
              child: const Text('Sign Up',
                  style: TextStyle(color: Colors.purpleAccent, fontSize: 18)),
            )
          ],
        ),
        Consumer(
          builder: (context, ref, child) {
            final signIn = ref.watch(loginScreenController).isSignIn;

            return signIn
                ? CircularProgressIndicator(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )
                : ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () async {
                      await ref
                          .read(loginScreenController.notifier)
                          .signInWithEmailAndPassword(
                              email: 'hasaneke1000@gmail.com',
                              password: '6145450fb');
                      if (ref.read(authNotifier) != null) {
                        AutoRouter.of(context).replace(const TabScreen());
                      } else {}
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 22),
                    ));
          },
        ),
      ],
    );
  }
}
