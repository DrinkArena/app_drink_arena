import 'package:flutter/widgets.dart';

class HandleVerificationForm {
  String? issamepasswordControllerValid(
      TextEditingController passwordController,
      TextEditingController samepasswordController) {
    return (passwordController.text == samepasswordController.text)
        ? null
        : "Les mots de passe ne sont pas identiques";
  }

  String? isCodeValide(TextEditingController codeController) {
    if (codeController.text.length == 6) {
      if (int.tryParse(codeController.text) != null) {
        return null;
      }
      return "Le code doit être composé de chiffres";
    }
    return "Le code doit contenir 6 caractères";
  }

  String? isPseudoValid(TextEditingController pseudoController) {
    if (pseudoController.text.length >= 3) {
      return null;
    }
    return "Le pseudo doit contenir au moins 3 caractères";
  }

  String? isEmailValid(TextEditingController emailController) {
    if (emailController.text.contains('@')) {
      return null;
    }
    return "Saisir un email valide";
  }

  String? isPasswordValid(TextEditingController passwordController) {
    if (passwordController.text.length >= 8) {
      //           passwordController.text.contains(RegExp(r'[0-9]')) &&
      // passwordController.text.contains(RegExp(r'[A-Z]')) &&
      // passwordController.text.contains(RegExp(r'[a-z]'))
      return null;
    }
    return "Le mot de passe doit au moins 8 caractères, une majuscule, une minuscule et un chiffre";
  }

  String? isNameValid(TextEditingController nameController) {
    if (nameController.text.length >= 3) {
      // no special characters
      if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
          .hasMatch(nameController.text)) {
        return "Le nom ne doit pas contenir de caractères spéciaux";
      }
      return null;
    }
    return "Le nom doit contenir au moins 3 caractères";
  }
}
