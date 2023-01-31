import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/screens/settings.dart';
import 'package:hello_world/screens/tournaments.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomePage(),
      const TournamentsPage(),
      const SettingsPage()
    ];
    return screens[index];
  }
}
