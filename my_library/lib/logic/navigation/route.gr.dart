// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../presentation/auth/login/login_screen.dart' as _i3;
import '../../presentation/auth/reset_password_page/reset_password_screen.dart'
    as _i5;
import '../../presentation/auth/sign_up_page/sign_up_screen.dart' as _i4;
import '../../presentation/home/tab_bar_page/tab_bar_screen.dart' as _i2;
import '../../presentation/splash/splash_view.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashView.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashView());
    },
    TabScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.TabScreen());
    },
    LoginScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.LoginScreen());
    },
    SignUpScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SignUpScreen());
    },
    PasswordResetScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PasswordResetScreen());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SplashView.name, path: '/'),
        _i6.RouteConfig(TabScreen.name, path: '/tab-screen'),
        _i6.RouteConfig(LoginScreen.name, path: '/login-screen'),
        _i6.RouteConfig(SignUpScreen.name, path: '/sign-up-screen'),
        _i6.RouteConfig(PasswordResetScreen.name,
            path: '/password-reset-screen')
      ];
}

/// generated route for
/// [_i1.SplashView]
class SplashView extends _i6.PageRouteInfo<void> {
  const SplashView() : super(SplashView.name, path: '/');

  static const String name = 'SplashView';
}

/// generated route for
/// [_i2.TabScreen]
class TabScreen extends _i6.PageRouteInfo<void> {
  const TabScreen() : super(TabScreen.name, path: '/tab-screen');

  static const String name = 'TabScreen';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreen extends _i6.PageRouteInfo<void> {
  const LoginScreen() : super(LoginScreen.name, path: '/login-screen');

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i4.SignUpScreen]
class SignUpScreen extends _i6.PageRouteInfo<void> {
  const SignUpScreen() : super(SignUpScreen.name, path: '/sign-up-screen');

  static const String name = 'SignUpScreen';
}

/// generated route for
/// [_i5.PasswordResetScreen]
class PasswordResetScreen extends _i6.PageRouteInfo<void> {
  const PasswordResetScreen()
      : super(PasswordResetScreen.name, path: '/password-reset-screen');

  static const String name = 'PasswordResetScreen';
}
