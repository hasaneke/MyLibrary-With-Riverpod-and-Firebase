import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/presentation/auth/reset_password_page/provider/reset_password_controller.dart';

class PasswordResetScreen extends HookConsumerWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Login Help',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 25),
              ),
            ),
            Column(
              children: [
                Text(
                  'Find your account',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 27),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Enter your email linked to your account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15)),
              ],
            ),
            Column(
              children: [
                TextField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 17),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!)),
                    hintText: 'email',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isSending = ref.watch(isSendingProvider);
                    return isSending
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              final succeed = await ref
                                  .read(resetPasswordController.notifier)
                                  .sendPasswordRequest(
                                      email: 'hasaneke1000@gmail.com');

                              if (succeed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Password reset request is sent')));
                              }
                            },
                            child: Text(
                              'Send password reset request',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                            ));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
