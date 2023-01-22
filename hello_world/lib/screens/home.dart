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
      // backgroundColor: Colors.black87,
      body: Container(
        // ignore: sort_child_properties_last
        child: ListView.builder(
          itemCount: tournametsData == null ? 0 : tournametsData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://media-3.api-sports.io/football/leagues/4.png"),
                    ),
                    Center(
                      child: Text(
                        "${tournametsData[index]["game"]}",
                        // textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12.7,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(164, 255, 255, 255)),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      // constraints: BoxConstraints(),
                      onPressed: () {
                        print("tv button");
                      },
                      icon: const Icon(Icons.tv),
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/a.png"),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
