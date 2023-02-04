import 'package:flutter/material.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'package:hello_world/widgets/navigator/BottonNavigator.dart';
import 'package:hello_world/widgets/navigator/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.orange,
      title: 'nsportTV',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'nsportTV'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  BottonNavigator? myBN;

  @override
  void initState() {
    myBN = BottonNavigator(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: const DrawerBotton(),
      bottomNavigationBar: myBN,
      body: Routes(
        index: index,
      ),
    );
  }
}
