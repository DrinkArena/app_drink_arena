import 'dart:async';

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

  final GameRepository _gameRepository = GameRepository();

  bool isOwner = false;
  bool isStarted = true;

  late StreamController<String> streamController =
      StreamController<String>(onListen: () async {
    while (isStarted) {
      await Future.delayed(const Duration(seconds: 5));
      streamController.add(await _gameRepository.getPledge());
      if (await _gameRepository.getState() == "FINISHED") {
        isStarted = false;
        await Future.delayed(const Duration(seconds: 4));
        await streamController.close();
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const GameLobbyScreen()),
            (Route<dynamic> route) => false);
      }
    }
    if (isStarted == false) {
      await streamController.close();
    }
  }, onCancel: () async {
    isStarted = false;
    await Future.delayed(const Duration(seconds: 4));
    _gameRepository.leaveGame();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const GameLobbyScreen()),
        (Route<dynamic> route) => false);
  });

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
                          child: FutureBuilder<List<Player>>(
                            future: _gameRepository.getRoom(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return PopupMenuButton<Player>(
                                  color: const Color(0xFF70A2C7),
                                  icon: const Icon(
                                    Icons.group,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) => [
                                    ...snapshot.data!.map((e) => PopupMenuItem(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          value: e,
                                          child: Text(e.username!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ))
                                  ],
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
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
                              isStarted = false;
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
                            StreamBuilder(
                              stream: streamController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    color: const Color(0xFF6B5E5E),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                        child: Text(
                                      snapshot.data.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
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
                                  _gameRepository.startGame();
                                },
                                child: Text(
                                  'Suivant',
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
