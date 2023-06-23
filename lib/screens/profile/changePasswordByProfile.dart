import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class ChangePasswordByProfileScreen extends StatefulWidget {
  const ChangePasswordByProfileScreen({super.key});

  @override
  State<ChangePasswordByProfileScreen> createState() =>
      _ChangePasswordByProfileScreenState();
}

class _ChangePasswordByProfileScreenState
    extends State<ChangePasswordByProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: background(),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Profil',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Container(
                    height: 5,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 261,
                      height: 80,
                      child: TextFormField(
                        controller: oldPasswordController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF3F3636),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Ancien mot de passe',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre mdp';
                          }
                          // if (value != oldPasswordController.text)
                          //   return 'Mot de passe incorrect';
                        },
                      ),
                    ),
                    SizedBox(
                        width: 261,
                        height: 90,
                        child: TextFormField(
                          controller: newPasswordController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF3F3636),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Nouveau mot de passe',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir votre mdp';
                            }
                            return handleVerificationForm
                                .isPasswordValid(newPasswordController);
                          },
                        )),
                    SizedBox(
                        width: 261,
                        height: 90,
                        child: TextFormField(
                          controller: newPasswordController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF3F3636),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Confirmer',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir un mdp';
                            }
                            return handleVerificationForm
                                .issamepasswordControllerValid(
                                    newPasswordController,
                                    confirmNewPasswordController);
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFF72B851),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.pushNamed(context, '/menu');
                            },
                            child: Text(
                              'Retour',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFB85151),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/menu');
                              }
                            },
                            child: Text(
                              'Changer',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ))),
    );
  }
}
