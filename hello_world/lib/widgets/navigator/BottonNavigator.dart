import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottonNavigator extends StatefulWidget {
  final Function currentIndex;
  const BottonNavigator({Key? key, required this.currentIndex})
      : super(key: key);

  // int _index = 0;
  @override
  State<BottonNavigator> createState() => _BottonNavigatorState();
}

class _BottonNavigatorState extends State<BottonNavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: const Color.fromARGB(232, 0, 0, 0),
        selectedIndex: index,
        onTabChange: (int i) {
          setState(
            () {
              index = i;
              widget.currentIndex(i);
            },
          );
        },
        // ignore: prefer_const_literals_to_create_immutables
        tabs: [
          const GButton(
            iconColor: Color.fromARGB(181, 255, 255, 255),
            icon: Icons.tv,
            text: " Matches",
            iconActiveColor: Colors.orange,
            textColor: Colors.orange,
          ),
          const GButton(
            iconColor: Color.fromARGB(181, 255, 255, 255),
            icon: Icons.sports_soccer,
            text: " Tournamets",
            iconActiveColor: Colors.orange,
            textColor: Colors.orange,
          ),
          const GButton(
            iconColor: Color.fromARGB(181, 255, 255, 255),
            icon: Icons.settings,
            text: " Settings",
            iconActiveColor: Colors.orange,
            textColor: Colors.orange,
          ),
        ]);
  }
}
