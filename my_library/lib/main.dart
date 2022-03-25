import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/core/constants/themes.dart';

import 'logic/navigation/route.gr.dart';

void main() async {
  final _appRouter = AppRouter();
  runApp(ProviderScope(
      child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Themes.limetheme,
          darkTheme: Themes.darkTheme)));
}
