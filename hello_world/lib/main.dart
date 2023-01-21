// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'package:hello_world/widgets/navigator/BottonNavigator.dart';
import 'package:hello_world/widgets/navigator/Routes.dart';
// import 'package:hello_world/screens/splash.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:video_player/video_player.dart';
// import 'package:hello_world/screens/match.dart';
// import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'App del cesar',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Cesar manda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
      appBar: AppBar(
        title: const Text("Principal Page"),
        backgroundColor: Colors.orange,
      ),
      endDrawer: const DrawerBotton(),
      bottomNavigationBar: myBN,
      body: Routes(index: index),
    );
  }
}
