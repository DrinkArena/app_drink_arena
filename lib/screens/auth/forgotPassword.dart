import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/repositories/userRepository.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: background(),
        child: Stack(children: [
          Container(
            alignment: const Alignment(0.75, 0.90),
            child: Image.asset('assets/images/lemon.png'),
          ),
          Container(
            alignment: const Alignment(-1, -0.3),
            child: Image.asset('assets/images/cocktail.png'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text(
                    'Drink Arena',
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
                ]),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 261,
                        height: 80,
                        child: TextFormField(
                          controller: emailController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return handleVerificationForm
                                  .isEmailValid(emailController);
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF3F3636),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Email d\'envoi',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        width: 261,
                        height: 63,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(114, 184, 81, 1),
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
                              //   userRepository
                              //       .recoverPassword(emailController.text)
                              //       .then((value) {
                              //     Navigator.pushNamed(
                              //         context, '/verification-code');
                              //   }).catchError((error) {
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //         content: Text('Email invalide'),
                              //       ),
                              //     );
                              //   });
                              Navigator.pushNamed(
                                  context, '/verification-code');
                            }
                          },
                          child: Text(
                            'Envoyer',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 228,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF70A2C7),
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
                        },
                        child: Text(
                          'Retour à la connexion',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
