import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class HandleError {
  final UserRepository _userRepository = UserRepository();
  TextStyle textStyleError = const TextStyle(
      fontSize: 16, fontFamily: 'Kavoon', color: Color(0xFFFF0000));

  Widget errorOnRoom(int statusCode, BuildContext context) {
    switch (statusCode) {
      case 401:
        _userRepository.logout();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return Text('Vous n\'êtes pas connecté', style: textStyleError);
      case 404:
        return Column(
          children: [
            buttonBack(context),
            Text('La salle n\'existe pas', style: textStyleError),
          ],
        );
      case 403:
        return Column(
          children: [
            buttonBack(context),
            Text('Vous n\'avez pas accès à cette salle', style: textStyleError),
          ],
        );
      case 500:
        _userRepository.logout();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return Text('Erreur serveur', style: textStyleError);
      default:
        return Text('Erreur inconnue', style: textStyleError);
    }
  }

  SnackBar errorOnLogin(int statusCode, BuildContext context) {
    switch (statusCode) {
      case 401:
        return SnackBar(
            content: Text('Mot de passe incorrect', style: textStyleError));

      case 500:
        return SnackBar(content: Text('Erreur serveur', style: textStyleError));
      default:
        return SnackBar(
            content: Text('Erreur inconnue', style: textStyleError));
    }
  }

  Widget errorOnProfile(int statusCode, BuildContext context) {
    switch (statusCode) {
      case 401:
        _userRepository.logout();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return Text('Vous n\'êtes pas connecté', style: textStyleError);
      case 500:
        _userRepository.logout();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return Text('Erreur serveur', style: textStyleError);
      default:
        return Text('Erreur inconnue', style: textStyleError);
    }
  }

  Widget buttonBack(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
      padding: EdgeInsets.all(10.0),
      splashRadius: 20.0,
    );
  }
}
