import 'package:app_drink_arena/screens/auth/changePassword.dart';
import 'package:app_drink_arena/screens/auth/forgotPassword.dart';
import 'package:app_drink_arena/screens/auth/verificationCode.dart';
// import 'package:app_drink_arena/screens/history/history.dart';
// import 'package:app_drink_arena/screens/profile/changePasswordByProfile.dart';
// import 'package:app_drink_arena/screens/profile/myChallenge.dart';
import 'package:app_drink_arena/screens/profile/profile.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:app_drink_arena/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization();
  runApp(const MyApp());
}

Future initialization() async {
  await getEnv();
  await Future.delayed(const Duration(seconds: 3));
}

Future getEnv() async {
  await dotenv.load(fileName: ".env");
}

Future<bool> checkAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token != null) {
    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drink Arena',
        theme: theme(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/verification-code': (context) => const VerificationCodeScreen(),
          '/change_password': (context) => const ChangePasswordScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/menu': (context) => NavBarWidget(),
        },
        home: FutureBuilder(
          future: checkAuth(),
          builder: (context, snapshot) {
            FlutterNativeSplash.remove();

            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return NavBarWidget();
              } else {
                return const LoginScreen();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
