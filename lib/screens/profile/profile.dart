import 'package:app_drink_arena/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drink Arena'),
      ),
      body: Container(
        decoration: background(),
        child: Text('Home Screen'),
      ),
    );
  }
}
