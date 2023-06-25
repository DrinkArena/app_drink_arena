import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class MyPledgeScreen extends StatefulWidget {
  const MyPledgeScreen({super.key});

  @override
  State<MyPledgeScreen> createState() => _MyPledgeScreenState();
}

class _MyPledgeScreenState extends State<MyPledgeScreen> {
  List<String> dataTest = [
    "'Test de goût les yeux bandés : Bandez les yeux de chaque participant et faites-leur goûter différents aliments ou boissons pour voir s'ils peuvent deviner ce que c'est.",
    "Relais de crevaison de ballons : Divisez-vous en équipes et organisez une course de relais où chaque personne doit s'asseoir sur un ballon pour le faire éclater avant que le membre suivant de l'équipe puisse commencer.",
    "Tour de guimauves : Fournissez à chaque équipe un sac de guimauves et des cure-dents. Challengez-les à construire la plus haute tour en utilisant uniquement ces matériaux dans un délai imparti.",
    "Battle de danse : Organisez une compétition de danse où chaque personne montre tour à tour ses meilleurs mouvements de danse. Le groupe peut voter pour le gagnant.",
    "Jeu de mémoire : Disposez plusieurs objets sur un plateau et donnez à tout le monde une minute pour les mémoriser. Ensuite, couvrez le plateau et demandez à chacun d'écrire autant d'objets qu'il se souvient. La personne avec le plus de bonnes réponses gagne."
  ];
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
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ('Nombre de gage : ${dataTest.length}/10'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: dataTest.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF3F3636),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 35),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            dataTest[index],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {},
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
