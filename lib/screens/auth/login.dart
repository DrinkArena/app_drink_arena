import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late User user;
  final UserRepository userRepository = UserRepository();
  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();

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
                          controller: usernameController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF3F3636),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Pseudo',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir un pseudo';
                            }
                            return handleVerificationForm
                                .isPseudoValid(usernameController);
                          },
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      SizedBox(
                          width: 261,
                          height: 90,
                          child: TextFormField(
                            controller: passwordController,
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
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir un mdp';
                              }
                              return null;
                            },
                          )),
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        width: 261,
                        height: 63,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(114, 184, 81, 1),
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
                              userRepository
                                  .login(usernameController.text,
                                      passwordController.text)
                                  .then((value) => {
                                        usernameController.clear(),
                                        passwordController.clear(),
                                        Navigator.pop(context),
                                        Navigator.pushNamed(context, '/home')
                                      })
                                  .catchError((onError) => {print(onError)});
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/menu');
                            }
                          },
                          child: Text(
                            'Connecter',
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
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Pas de compte ?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
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
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text(
                          'Mot de passe oublié ?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    Container(
                      width: 230,
                      height: 40,
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
                          Navigator.pushNamed(context, '/menu');
                        },
                        child: Text(
                          'Connecter en tant qu\'invité',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
