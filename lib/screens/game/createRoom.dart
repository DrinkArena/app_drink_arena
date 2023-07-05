import 'package:app_drink_arena/helpers/handle_verification_form.dart';
import 'package:app_drink_arena/repositories/game_repository.dart';
import 'package:app_drink_arena/screens/game/gameRoom.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameRoom = TextEditingController();
  final GameRepository _gameRepository = GameRepository();

  final HandleVerificationForm handleVerificationForm =
      HandleVerificationForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: background(),
            child: Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Creer une salle',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(children: [
                            SizedBox(
                              width: 261,
                              height: 80,
                              child: TextFormField(
                                controller: nameRoom,
                                style: Theme.of(context).textTheme.bodyMedium,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un nom de salle';
                                  }
                                  return handleVerificationForm
                                      .isNameValid(nameRoom);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFF3F3636),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Nom de salle',
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                ),
                              ),
                            ),
                            Container(
                              width: 158,
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
                                  if (_formKey.currentState!.validate()) {
                                    _gameRepository.createRoom(nameRoom.text);
                                    nameRoom.clear();
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const GameRoomScreen(),
                                        ),
                                      );
                                    });
                                  }
                                },
                                child: Text(
                                  'Créer',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ])
                        ])))));
  }
}
