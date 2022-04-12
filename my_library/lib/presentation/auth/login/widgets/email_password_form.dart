import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/auth/login/controller/login_screen_controller.dart';

class EmailPasswordForm extends HookConsumerWidget {
  const EmailPasswordForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _focuseNode1 = FocusNode();
    final _focuseNode2 = FocusNode();
    String email = ' ';
    String password = ' ';
    final _formKey = GlobalKey<FormState>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(15)),
          child: Form(
            key: _formKey,
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
                    if (!value!.contains('@') || value.isEmpty) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  onSaved: (emailText) {
                    email = emailText!;
                  },
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
                  onSaved: (passwordText) {
                    password = passwordText!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
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
            final state = ref.watch(loginScreenController);
            return state is EmailPasswordSignin
                ? CircularProgressIndicator(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )
                : ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loginScreenController.notifier)
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                      }
                    },
                    child: Text(
                      'Login',
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
