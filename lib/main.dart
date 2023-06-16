import 'package:app_drink_arena/screens/auth/changePassword.dart';
import 'package:app_drink_arena/screens/auth/forgotPassword.dart';
import 'package:app_drink_arena/screens/auth/sendEmailRecovery.dart';
import 'package:app_drink_arena/screens/auth/verificationCode.dart';
import 'package:app_drink_arena/screens/stat/stat.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

import 'screens/auth/login.dart';
import 'screens/auth/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Arena',
      theme: theme(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/verification-code': (context) => VerificationCodeScreen(),
        '/home': (context) => HomeScreen(),
        '/change_password': (context) => ChangePasswordScreen(),
        //'/settings': (context) => SettingsScreen(),
        //'/about': (context) => AboutScreen(),
        //'/contact': (context) => ContactScreen(),
        // '/help': (context) => HelpScreen(),
      },
    );
  }
}
