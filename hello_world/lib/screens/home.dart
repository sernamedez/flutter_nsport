import 'package:flutter/material.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map data;
  // late Map registerData;
  late List tournametsData = [];
  // late List registerTournametsData = [];

  getTournamets() async {
    http.Response response =
        await http.get("http://127.0.0.1:3000/pirlo/match-page");
    data = json.decode(response.body);
    setState(() {
      tournametsData = data['data'];
    });
  }

  // reloadTournamets() async {
  //   http.Response response = await http.get("http://127.0.0.1:3000/pirlo/");
  //   registerData = json.decode(response.body);
  //   setState(() {
  //     registerTournametsData = data['data'];
  //   });
  // }

  @override
  void initState() {
    getTournamets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tournametsData == null ? 0 : tournametsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[Text("${tournametsData[index]["game"]}")],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.replay_rounded,
        ),
        onPressed: () {
          print("Se toco el boton de recargar");
        },
      ),
    );
  }
}
