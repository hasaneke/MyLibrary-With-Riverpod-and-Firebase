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
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Login Help',
                // style: TextStyle(
                //     color: context.textTheme.bodyText1!.color, fontSize: 25),
              ),
            ),
            Column(
              children: const [
                Text(
                  'Find your account',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Enter your email linked to your account'),
              ],
            ),
            Column(
              children: [
                const TextField(
                  //controller: controller.textController,
                  decoration: InputDecoration(
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
                            child: const Text(
                              'Send password reset request',
                              // style: TextStyle(
                              //     color: Get.theme.textTheme.bodyText1!.color),
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
