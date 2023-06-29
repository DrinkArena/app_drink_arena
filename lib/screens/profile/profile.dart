import 'package:app_drink_arena/repositories/user_repository.dart';
import 'package:app_drink_arena/screens/profile/changePasswordByProfile.dart';
import 'package:app_drink_arena/screens/profile/myPledge.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: background(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        'Profil',
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            child: const Icon(
                              Icons.person_outlined,
                              color: Colors.black,
                              size: 56,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF3F3636),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 35),
                            // get username in the local storage
                            child: FutureBuilder<String>(
                              future: userRepository.getUser(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  );
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyPledgeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF70A2C7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 90),
                    ),
                    child: Text(
                      'Tout vos gages',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordByProfileScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB85151),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 40),
                          ),
                          child: Text(
                            'Changer de mot de passe',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: TextButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: const Text('Supprimer mon compte'),
                                    content: const Text(
                                        'Etes vous sur de vouloir supprimer votre compte ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Annuler'),
                                        child: const Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () => {
                                          // userRepository.deleteUser(),
                                          Navigator.pop(context, 'Supprimer')
                                        },
                                        child: const Text('Supprimer'),
                                      ),
                                    ],
                                  ))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB85151),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 40),
                          ),
                          child: Text(
                            'Supprimer mon compte',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
