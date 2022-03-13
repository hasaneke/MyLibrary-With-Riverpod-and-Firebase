import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:authentication/exceptions/auth_exception.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/logic/providers/auth_state.dart';
import 'package:my_library/presentation/auth/login/provider/login_screen_controller.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthException?>(authExceptionProvider, (previous, exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exception!.toString()),
          duration: const Duration(seconds: 1),
        ),
      );
    });
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 3, child: welcomeWidget()),
                Expanded(flex: 7, child: AuthWidget()),
              ],
            ),
          ),
        ));
  }
}

Row welcomeWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 25,
        height: 1,
        color: Colors.black,
      ),
      const Text(
        'Welcome to My Library',
        style: TextStyle(fontSize: 27),
      ),
      Container(
        width: 25,
        height: 1,
        color: Colors.black,
      ),
    ],
  );
}

class AuthWidget extends HookConsumerWidget {
  final _focuseNode1 = FocusNode();
  final _focuseNode2 = FocusNode();

  AuthWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emailPasswordForm(context),
                const SizedBox(
                  height: 70,
                ),
                googleButton(ref.read, context),
                Padding(
                  padding: const EdgeInsets.only(left: 175),
                  child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .navigate(const PasswordResetScreen());
                      },
                      child: const Text(
                        'I forgot my password',
                        style: TextStyle(color: Colors.purple),
                      )),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  Column emailPasswordForm(BuildContext buildContext) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
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
                decoration: const InputDecoration(
                    hintText: 'email',
                    prefixIcon: Icon(Icons.mail, color: Colors.black)),
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
                decoration: const InputDecoration(
                  hintText: 'password',
                  prefixIcon: Icon(Icons.vpn_key, color: Colors.black),
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
                AutoRouter.of(buildContext).navigate(const SignUpScreen());
              },
              child: const Text('Sign Up',
                  style: TextStyle(color: Colors.purpleAccent, fontSize: 18)),
            )
          ],
        ),
        Consumer(
          builder: (context, ref, child) {
            final signIn = ref.watch(isEmailSignIn);

            log('built');
            return signIn
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(loginScreenController.notifier)
                          .signInWithEmailAndPassword(
                              email: 'hasaneke1000@gmail.com',
                              password: '6145450fb');
                      if (ref.read(authStateProvider) != null) {
                        log('?');
                        AutoRouter.of(context).replace(const TabScreen());
                      } else {
                        log('wtf');
                      }
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ));
          },
        ),
      ],
    );
  }

  Padding googleButton(Reader read, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: MaterialButton(
        height: 60,
        color: Colors.lime[50],
        onPressed: () async {
          await read(authStateProvider.notifier).signInWithGoogle();
          if (read(authStateProvider) != null) {
            AutoRouter.of(context).replace(const TabScreen());
          }
        },
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: const Image(
                image: AssetImage('assets/google_light.png'),
                height: 35,
              ),
            ),
            const SizedBox(
              width: 140,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Google Sign In',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
