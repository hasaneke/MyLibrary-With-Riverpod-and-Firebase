import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/auth_state.dart';
import 'package:my_library/presentation/auth/sign_up_page/provider/sign_up_controller.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        // backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Center(
        child: Form(
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
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: 'email'),
                          onSaved: (value) {
                            //controller.email.value = value!;
                          },
                        ),
                        TextFormField(
                          //controller: controller.passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'password'),
                          // validator: (value) {
                          //   if (value!.length < 6) {
                          //     Get.showSnackbar(
                          //       const GetSnackBar(
                          //         message:
                          //             'Invaild Password(must be at least 6 charachter long)',
                          //         duration: Duration(seconds: 3),
                          //       ),
                          //     );
                          //     return 'invalid password';
                          //   }
                          //   return null;
                          // },
                          // onSaved: (value) {
                          //   controller.password.value = value!;
                          // },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'password_again'),
                          // validator: (value) {
                          //   if (value != controller.passwordController.text) {
                          //     Get.showSnackbar(GetSnackBar(
                          //         message: 'passwords_are_not_matched'.tr,
                          //         duration: const Duration(seconds: 1)));
                          //     return 'error';
                          //   }
                          //   return null;
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Consumer(
                    builder: (context, ref, child) {
                      bool isSignUp = ref.watch(isSigningUp);
                      log('built');
                      return isSignUp
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                await ref
                                    .read(signUpController.notifier)
                                    .signUp(
                                        email: 'hasaneke1000@gmail.com',
                                        password: '6145450fb');
                                if (ref.read(authStateProvider) != null) {
                                  log('Sign up succesfull');
                                } else {
                                  log('what happened?');
                                }
                              },
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),

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
