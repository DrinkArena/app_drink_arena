import 'package:app_drink_arena/screens/auth/changePassword.dart';
import 'package:app_drink_arena/screens/auth/forgotPassword.dart';
import 'package:app_drink_arena/screens/auth/verificationCode.dart';
import 'package:app_drink_arena/screens/profile/changePasswordByProfile.dart';
import 'package:app_drink_arena/screens/profile/myChallenge.dart';
// import 'package:app_drink_arena/screens/history/history.dart';
// import 'package:app_drink_arena/screens/profile/changePasswordByProfile.dart';
// import 'package:app_drink_arena/screens/profile/myChallenge.dart';
import 'package:app_drink_arena/screens/profile/profile.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:app_drink_arena/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        '/change_password': (context) => ChangePasswordScreen(),
        '/profile': (context) => ProfileScreen(),
        // '/': (context) => LandingScreen(),
        '/menu': (context) => NavBarWidget(),
        //  '/history': (context) => HistoryScreen(),
        // '/profile/my_challenge': (context) => MyChallengeScreen(),
        // '/profile/change_password_by_profile': (context) =>
        // ChangePasswordByProfileScreen(),
        //'/about': (context) => AboutScreen(),
        //'/contact': (context) => ContactScreen(),
        // '/help': (context) => HelpScreen(),
      },
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<bool> checkIfUserShouldSwitchPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (userString != null) {
      return false;
      // return true; // => inverse for deploy
    }
    return true;
  }

  @override
  Future<void> initState() async {
    super.initState();
    Future<bool> shouldSwitch = checkIfUserShouldSwitchPage();
    if (!await shouldSwitch) {
      Future.delayed(Duration.zero, () {
        Navigator.popAndPushNamed(context, '/menu');
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.popAndPushNamed(context, '/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: background(),
        child: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
