import 'package:app_drink_arena/screens/auth/changePassword.dart';
import 'package:app_drink_arena/screens/auth/forgotPassword.dart';
import 'package:app_drink_arena/screens/auth/verificationCode.dart';
import 'package:app_drink_arena/screens/profile/changePasswordByProfile.dart';
import 'package:app_drink_arena/screens/profile/myPledge.dart';
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
  runApp(MyApp());
}

Future initialization() async {
  await getEnv();
  await Future.delayed(Duration(seconds: 3));
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
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          '/verification-code': (context) => VerificationCodeScreen(),
          '/change_password': (context) => ChangePasswordScreen(),
          '/profile': (context) => ProfileScreen(),
          '/menu': (context) => NavBarWidget(),
          //  '/history': (context) => HistoryScreen(),
          // '/profile/change_password_by_profile': (context) =>
          // ChangePasswordByProfileScreen(),
          //'/about': (context) => AboutScreen(),
          //'/contact': (context) => ContactScreen(),
          // '/help': (context) => HelpScreen(),
        },
        home: FutureBuilder(
          future: checkAuth(),
          builder: (context, snapshot) {
            FlutterNativeSplash.remove();

            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return NavBarWidget();
              } else {
                return LoginScreen();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
