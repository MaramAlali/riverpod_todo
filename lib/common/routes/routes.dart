import 'package:flutter/material.dart';
import 'package:riverpod_todo/features/todo/pages/home_page.dart';
import 'package:riverpod_todo/features/todo/pages/login_page.dart';
import 'package:riverpod_todo/features/todo/pages/otp_page.dart';
import '../../features/onboarding/pages/on_boarding.dart';

class Routes {
  static const String home = "home";
  static const String onBoarding = "onboarding";
  static const String otp = "otp";
  static const String login = "login";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (context) => const OnBoarding());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => OtpPage(
                  smsCodeId: args['smsCodeId'],
                  phone: args['phone'],
                ));
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
