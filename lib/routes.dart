import 'package:auth_shared_pref/model/user_model.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/user_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case UserScreen.routeName:
      UserModel? user = routeSettings.arguments as UserModel?;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => UserScreen(
                user: user,
              ));

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(child: Text("Screen does not exist!...")),
              ));
  }
}
