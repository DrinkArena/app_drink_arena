import 'package:flutter/material.dart';
import 'sign_in.dart';
// import 'recoverPassword.dart';
// import 'recoverPassword.dart';

enum FormData {
  email,
  password,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FormData? selected;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFA800),
              Color(0xFFB94DBB),
            ],
            stops: [0.0, 0.7344],
          ),
        ),
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
                Column(
                  children: [
                    SizedBox(
                      width: 261,
                      height: 52,
                      child: TextField(
                        controller: emailController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF3F3636),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Email',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                        width: 261,
                        height: 52,
                        child: TextField(
                          controller: passwordController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF3F3636),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Mot de passe',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
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
                          //Navigator.pop(context);
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return ();
                          // }));
                        },
                        child: Text(
                          'Connecter',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 228,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF70A2C7),
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return (SignInScreen());
                          }));
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
                        color: Color(0xFF70A2C7),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
          )
        ]),
      ),
    );
  }
}
