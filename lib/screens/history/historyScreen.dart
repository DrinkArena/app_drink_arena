import 'package:app_drink_arena/models/history.dart';
import 'package:app_drink_arena/repositories/history_repository.dart';
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
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: const Color(0xFF3F3636),
                borderRadius: BorderRadius.circular(30),
              ),
              child: HistoryList(),
            )
          ],
        ),
      ),
    ));
  }
}

class HistoryList extends StatelessWidget {
  HistoryList({Key? key}) : super(key: key);

  final HistoryRepository historyRepository = HistoryRepository();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<History>>(
      future: historyRepository.getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final List<History> histories = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: histories.length,
            itemBuilder: (context, index) {
              final History history = histories[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      history.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Text(
                      '${history.created_at.day}/${history.created_at.month}/${history.created_at.year}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'Aucune donnée',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
      },
    );
  }
}
