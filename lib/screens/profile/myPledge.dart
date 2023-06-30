import 'package:app_drink_arena/models/pledge.dart';
import 'package:app_drink_arena/repositories/pledge_repository.dart';
import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class MyPledgeScreen extends StatefulWidget {
  const MyPledgeScreen({super.key});

  @override
  State<MyPledgeScreen> createState() => _MyPledgeScreenState();
}

class _MyPledgeScreenState extends State<MyPledgeScreen> {
  PledgeRepository pledgeRepository = PledgeRepository();
  TextEditingController _newPledge = TextEditingController();

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
                ],
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Pledge> pledges = snapshot.data as List<Pledge>;
                    int pledgesLength = pledges.length;

                    return Column(children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Nombre de gages : $pledgesLength/30',
                            style: Theme.of(context).textTheme.bodySmall,
                          )),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: ListView.builder(
                            itemCount: pledgesLength,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(pledges[index].title!),
                                onDismissed: (endToStart) {
                                  pledgeRepository
                                      .deletePledge(pledges[index].id!);
                                  new Future.delayed(const Duration(seconds: 1),
                                      () {
                                    setState(() {});
                                  });
                                },
                                background: Container(
                                  color: Colors.red,
                                  margin: EdgeInsets.only(bottom: 20),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3F3636),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      pledges[index].title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                    ]);
                  } else {
                    return Text('Loading...');
                  }
                },
                future: pledgeRepository.getPledges(),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xFF3F3636),
                            title: Text('Ecrivez votre nouveau gage',
                                style: Theme.of(context).textTheme.bodyMedium),
                            content: TextFormField(
                              keyboardType: TextInputType.multiline,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 5,
                              maxLength: 150,
                              controller: _newPledge,
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF72B851),
                                ),
                                onPressed: () {
                                  if (_newPledge.text.isNotEmpty) {
                                    PledgeRepository()
                                        .createPledge(_newPledge.text);
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      setState(() {
                                        _newPledge.clear();
                                      });
                                    });
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text('Ajouter',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72B851),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
