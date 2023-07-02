import 'dart:async';

import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/models/player.dart';
import 'package:app_drink_arena/repositories/game_repository.dart';
import 'package:app_drink_arena/screens/game/gameLobby.dart';
import 'package:app_drink_arena/screens/game/onGame.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class GameRoomScreen extends StatefulWidget {
  const GameRoomScreen({super.key});

  @override
  State<GameRoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  final GameRepository _gameRepository = GameRepository();

  bool toggleColor = false;
  late StreamController<List<Player>> streamController =
      StreamController<List<Player>>(onListen: () async {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      toggleColor = false;
      streamController.add(await _gameRepository.getRoom());
    }
  }, onCancel: () async {
    await streamController.close();
    await Future.delayed(const Duration(seconds: 7));
  });

  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: background(),
            child: Center(
                child: StreamBuilder(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        List<Player> players = snapshot.data as List<Player>;
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                  future: _gameRepository.getRoomId(),
                                  builder: ((context, snapshot) => Text(
                                        'Salle n°${snapshot.data}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ))),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3F3636),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          child: ListView.builder(
                                              itemCount: players.length,
                                              itemBuilder: (context, index) {
                                                toggleColor = !toggleColor;
                                                return Container(
                                                    color: toggleColor
                                                        ? const Color(
                                                            0xFF6B5E5E)
                                                        : Colors.transparent,
                                                    child: Row(
                                                      children: [
                                                        players[index].isOwner!
                                                            ? const Icon(
                                                                Icons
                                                                    .front_hand,
                                                                color: Colors
                                                                    .white,
                                                                size: 56,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .person_outlined,
                                                                color: Colors
                                                                    .white,
                                                                size: 56,
                                                              ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: Text(
                                                            players[index]
                                                                .username!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                              })),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            width: 126,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: const Color(0xFFB85151),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 4,
                                                )
                                              ],
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                _gameRepository.leaveGame();
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const GameLobbyScreen(),
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Text(
                                                'Annuler',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ),
                                          ),
                                          FutureBuilder(
                                            future: _gameRepository.isOwner(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return snapshot.data!
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 20),
                                                        width: 126,
                                                        height: 55,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: const Color(
                                                              0xFF72B851),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.25),
                                                              offset:
                                                                  Offset(0, 4),
                                                              blurRadius: 4,
                                                            )
                                                          ],
                                                        ),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            _gameRepository
                                                                .startGame();
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                                () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const OnGameScreen(),
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: Text(
                                                            'Jouer',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                        ))
                                                    : Container();
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ]),
                              )
                            ]);
                      } else if (snapshot.hasError) {
                        return _gameRepository.errorOnRoom(
                            snapshot.error as int, context);
                      } else {
                        print(snapshot.connectionState);
                        return const Center(
                            child: Text(
                          'Chargement...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ));
                      }
                    }))));
  }
}
