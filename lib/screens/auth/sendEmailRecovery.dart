import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'login.dart';

enum FormData {
  email,
}

class SendEmailRecoveryScreen extends StatefulWidget {
  const SendEmailRecoveryScreen({super.key});
  @override
  State<SendEmailRecoveryScreen> createState() =>
      _SendEmailRecoveryScreenState();
}

class _SendEmailRecoveryScreenState extends State<SendEmailRecoveryScreen> {
  FormData? selected;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Envoyer',
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return (const LoginScreen());
                          }));
                        },
                        child: Text(
                          'Retour à la connexion',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
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
                      // child: TextButton(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //     Navigator.of(context)
                      //         .push(MaterialPageRoute(builder: (context) {
                      //       return ();
                      //     }));
                      //   },
                      child: Text(
                        'Envoyer un nouveau code',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    // ),
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
