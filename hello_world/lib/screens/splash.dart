import 'package:flutter/material.dart';
import 'package:hello_world/widgets/navigator/BottonNavigator.dart';
import 'package:hello_world/widgets/navigator/Routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int index = 0;
  BottonNavigator? myBN;

  @override
  void initState() {
    myBN = BottonNavigator(currentIndex: (i) {
      setState(() {
        index = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myBN,
      body: Routes(
        index: index,
      ),
    );
  }
}
