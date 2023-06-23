import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: background(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Historique',
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
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: const Color(0xFF3F3636),
                borderRadius: BorderRadius.circular(30),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

/*** example for chaht gpt 
 * class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<dynamic> objects = snapshot.data!;
          final List<MyObject> myObjects = objects
              .map((object) => MyObject.fromJson(object))
              .toList();
          // Now you have a list of MyObject instances to work with

          return ListView.builder(
            itemCount: myObjects.length,
            itemBuilder: (context, index) {
              final MyObject myObject = myObjects[index];
              return ListTile(
                title: Text(myObject.name),
                subtitle: Text(myObject.description),
              );
            },
          );
        }
      },
    );
  }
 */