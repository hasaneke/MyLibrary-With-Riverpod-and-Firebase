import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:authentication/exceptions/auth_exception.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';
import 'package:my_library/presentation/auth/login/controller/login_screen_controller.dart';
import 'package:my_library/presentation/auth/login/widgets/email_password_form.dart';
import 'package:my_library/presentation/auth/login/widgets/google_button.dart';
import 'package:my_library/presentation/auth/login/widgets/welcome_widget.dart';

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
    ref.listen<LoginState?>(loginScreenController, (previousState, newState) {
      if (newState is AuthSuccess) {
        AutoRouter.of(context).replace(const TabScreen());
      }
    });
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(flex: 3, child: WelcomeWidget()),
                Expanded(flex: 7, child: AuthWidget()),
              ],
            ),
          ),
        ));
  }
}

class AuthWidget extends HookConsumerWidget {
  const AuthWidget({Key? key}) : super(key: key);
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
                const EmailPasswordForm(),
                const Text('OR'),
                const GoogleButton(),
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
}
