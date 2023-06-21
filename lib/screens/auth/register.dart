import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/models/user.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController samepasswordController = TextEditingController();

  final UserRepository userRepository = UserRepository();
  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();
  late User user;

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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 261,
                          height: 80,
                          child: TextFormField(
                            controller: pseudoController,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Pseudo',
                              filled: true,
                              fillColor: const Color(0xFF3F3636),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir un pseudo';
                              }
                              return handleVerificationForm
                                  .isPseudoValid(pseudoController);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 261,
                          height: 80,
                          child: TextFormField(
                            controller: emailController,
                            style: Theme.of(context).textTheme.bodyMedium,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir un email';
                              }
                              return handleVerificationForm
                                  .isEmailValid(emailController);
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: const Color(0xFF3F3636),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 261,
                            height: 80,
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir un mot de passe';
                                }
                                return handleVerificationForm
                                    .isPasswordValid(passwordController);
                              },
                              style: Theme.of(context).textTheme.bodyMedium,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF3F3636),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Mot de passe',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                              ),
                            )),
                        SizedBox(
                            width: 261,
                            height: 80,
                            child: TextFormField(
                              controller: samepasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir un mot de passe';
                                }
                                return handleVerificationForm
                                    .issamepasswordControllerValid(
                                        passwordController,
                                        samepasswordController);
                              },
                              style: Theme.of(context).textTheme.bodyMedium,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF3F3636),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Confirmer mdp',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                              ),
                            )),
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
                                user = User(
                                  pseudo: pseudoController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                userRepository.saveUser(user).then((value) {
                                  Navigator.pushNamed(context, '/login');
                                });
                              }
                            },
                            child: Text(
                              'Créer',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    )),
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
                          'Déjà un compte ?',
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
