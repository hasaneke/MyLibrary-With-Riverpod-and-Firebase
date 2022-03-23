import 'package:auto_route/auto_route.dart';
import 'package:my_library/presentation/auth/login/login_screen.dart';
import 'package:my_library/presentation/auth/reset_password_page/reset_password_screen.dart';
import 'package:my_library/presentation/auth/sign_up_page/sign_up_screen.dart';
import 'package:my_library/presentation/home/add_card_page/add_card_screen.dart';
import 'package:my_library/presentation/home/my_category_detail_page/my_category_detail_screen.dart';
import 'package:my_library/presentation/home/tab_bar_page/tab_bar_screen.dart';
import 'package:my_library/presentation/splash/splash_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashView, initial: true),
    AutoRoute(page: TabScreen),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: SignUpScreen),
    AutoRoute(page: PasswordResetScreen),
    AutoRoute(page: CategoryDetailScreen),
    AutoRoute(page: AddCardScreen)
  ],
)
class $AppRouter {}
