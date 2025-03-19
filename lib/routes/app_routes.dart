import 'package:dream_al_emarat_app/routes/routes_names.dart';
import 'package:dream_al_emarat_app/views/HomeScreen.dart';
import 'package:dream_al_emarat_app/views/OtpScreen.dart';
import 'package:dream_al_emarat_app/views/forgot_screen.dart';
import 'package:dream_al_emarat_app/views/login_screen.dart';
import 'package:dream_al_emarat_app/views/onBoardingScreens.dart';
import 'package:dream_al_emarat_app/views/reset_password.dart';
import 'package:dream_al_emarat_app/views/signup_screen.dart';
import 'package:dream_al_emarat_app/views/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RoutesNames.home:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(url: args?['url'] ?? ""),
        );
      case RoutesNames.signIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutesNames.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RoutesNames.forgotScreen:
        return MaterialPageRoute(builder: (_) => ForgetPassScreen());
      case RoutesNames.onBoardingScreens:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case RoutesNames.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case RoutesNames.otpPassword:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text("No route defined")),
            );
          },
        );
    }
  }
}
