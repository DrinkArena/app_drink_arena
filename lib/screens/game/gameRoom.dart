import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/screens/game/onGame.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class GameRoomScreen extends StatefulWidget {
  const GameRoomScreen({super.key});

  @override
  State<GameRoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  List<String> dataTest = [
    "Pseudo1",
    "Pseudo2",
    "Pseudo3",
    "Pseudo4",
    "Pseudo5",
  ];

  bool toggleColor = false;

  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: background(),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3F3636),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.builder(
                                  itemCount: dataTest.length,
                                  itemBuilder: (context, index) {
                                    toggleColor = !toggleColor;
                                    return Container(
                                        color: toggleColor
                                            ? const Color(0xFF6B5E5E)
                                            : Colors.transparent,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.person_outlined,
                                              color: Colors.white,
                                              size: 56,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                dataTest[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            )
                                          ],
                                        ));
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  width: 126,
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
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Annuler',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  width: 126,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OnGameScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Jouer',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    )
                  ]),
            )));
  }
}
