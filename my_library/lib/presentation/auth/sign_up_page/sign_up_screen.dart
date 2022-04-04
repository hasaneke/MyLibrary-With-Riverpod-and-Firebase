import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/auth/sign_up_page/controller/sign_up_controller.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = ' ';
    String password = ' ';
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: Text(
                    'First Step To Your Library!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: 'email'),
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'password'),
                          validator: (value) {
                            if (value!.length < 6) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Invaild Password(must be at least 6 charachter long)'),
                                duration: Duration(seconds: 2),
                              ));
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'password_again'),
                          validator: (value) {
                            if (value != ref.watch(signUpController).password) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Passwords are not mathced'),
                                duration: Duration(seconds: 2),
                              ));
                              return 'error';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Consumer(
                    builder: (context, ref, child) {
                      bool isSignin = ref.watch(
                          signUpController.select((value) => value.isSigninIn));
                      return isSignin
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () async {
                                _formKey.currentState!.save();
                                await ref
                                    .read(signUpController.notifier)
                                    .signUp(email: email, password: password);
                                if (ref.watch(signUpController).isSuccess) {
                                  AutoRouter.of(context)
                                      .replace(const TabScreen());
                                }
                              },
                              child: Text('Sign Up',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 20)),

                              // ),
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
