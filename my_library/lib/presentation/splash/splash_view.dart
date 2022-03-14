import 'package:authentication/network/auth_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_library/data/repository/auth/auth_repository.dart';
import 'package:my_library/logic/navigation/route.gr.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
            'assets/my_library_icon.png',
          ),
        ),
      ),
    );
  }

  void initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final authRepositry = AuthRepository(authService: AuthService());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final isLoggedIn = await authRepositry.getCurrentUser();

    if (isLoggedIn == null) {
      AutoRouter.of(context).replace(const LoginScreen());
    } else {
      AutoRouter.of(context).replace(const TabScreen());
    }
  }
}
