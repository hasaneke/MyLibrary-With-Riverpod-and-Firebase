import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';

final isSendingProvider = StateProvider<bool>((ref) {
  return false;
});

final resetPasswordController = StateNotifierProvider((ref) {
  return ResetPasswordController(ref.read);
});

class ResetPasswordController extends StateNotifier {
  Reader read;

  ResetPasswordController(this.read, [state]) : super(state);

  Future<bool> sendPasswordRequest({required String email}) async {
    log('?');
    read(isSendingProvider.notifier).state = true;
    final isSuccesfull = await read(authNotifier.notifier)
        .sendPasswordResetRequest(email: email);
    read(isSendingProvider.notifier).state = false;
    log(isSuccesfull.toString());
    return isSuccesfull;
  }
}
