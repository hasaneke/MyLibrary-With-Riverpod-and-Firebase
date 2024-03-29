import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';
import 'package:my_library/product/navigator/route.gr.dart';

class SplashView extends StatefulHookConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashView2State();
}

class _SplashView2State extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        initApp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 120,
          width: 120,
          child: Image.asset(
            'assets/icon_white.png',
          ),
        ),
      ),
    );
  }

  void initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await ref.read(authNotifier.notifier).getCurrentUser();
    final user = ref.read(authNotifier);

    if (user == null) {
      AutoRouter.of(context).replace(const LoginScreen());
    } else {
      AutoRouter.of(context).replace(const TabScreen());
    }
  }
}
