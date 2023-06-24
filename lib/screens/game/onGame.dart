import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/models/player.dart';
import 'package:app_drink_arena/repositories/game_repository.dart';
import 'package:app_drink_arena/screens/game/gameLobby.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class OnGameScreen extends StatefulWidget {
  const OnGameScreen({super.key});

  @override
  State<OnGameScreen> createState() => _OnGameScreenState();
}

class _OnGameScreenState extends State<OnGameScreen> {
  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();

  GameRepository gameRepository = GameRepository();

  List<Player> dataTest = [
    Player(id: 1, username: 'test1', isOwner: true),
    Player(id: 2, username: 'test2', isOwner: false),
    Player(id: 3, username: 'test3', isOwner: false),
    Player(id: 4, username: 'test4', isOwner: false),
    Player(id: 5, username: 'test5', isOwner: false),
    Player(id: 6, username: 'test6', isOwner: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: background(),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, bottom: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF70A2C7),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: PopupMenuButton<Player>(
                            color: const Color(0xFF70A2C7),
                            icon: const Icon(
                              Icons.group,
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => [
                              ...dataTest.map((e) => PopupMenuItem(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    value: e,
                                    child: Text(e.username!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, right: 20),
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
                              // GameRepository().leaveGame();
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const GameLobbyScreen();
                              }));
                            },
                            child: Text(
                              'Quitter',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.only(top: 60),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3F3636),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: const Color(0xFF6B5E5E),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.5,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                  child: Text(
                                'Si tu as déja manger un tacos à 3 heure du matin après une fête alors bois 2 gorgé.',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
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
                                onPressed: () {},
                                child: Text(
                                  'Jouer',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        ))
                  ]),
            )));
  }
}
