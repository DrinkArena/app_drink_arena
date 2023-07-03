import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:app_drink_arena/screens/game/createRoom.dart';
import 'package:app_drink_arena/screens/game/joinRoom.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class GameLobbyScreen extends StatefulWidget {
  const GameLobbyScreen({super.key});

  @override
  State<GameLobbyScreen> createState() => _GameLobbyScreenState();
}

class _GameLobbyScreenState extends State<GameLobbyScreen> {
  UserRepository userRepository = UserRepository();

  @override
  initState() {
    userRepository.isTokenExpired().then((value) => value
        ? Navigator.of(context, rootNavigator: true).popAndPushNamed('/login')
        : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: background(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Que faire ?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Column(
                children: [
                  Container(
                    width: 271,
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
                            builder: (context) => const CreateRoomScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Creer une salle',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 271,
                    height: 55,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JoinRoomScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Rejoindre une salle',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 204,
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
                    userRepository.logout();
                    Navigator.of(context, rootNavigator: true)
                        .popAndPushNamed('/login');
                  },
                  child: Text(
                    'Se déconnecter',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
