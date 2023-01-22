import 'package:flutter/material.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'package:hello_world/widgets/navigator/Routes.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:hello_world/widgets/navigator/Routes.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  late Map data;
  late List tournametsData = [];
  late int index;

  getTournamets() async {
    http.Response response =
        await http.get("http://127.0.0.1:3000/tournamets/tournamets-page");
    data = json.decode(response.body);
    setState(() {
      tournametsData = data['data'];
    });
  }

  @override
  void initState() {
    getTournamets();
    setState(() {
      index = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   // ignore: sort_child_properties_last
      //   child: CustomScrollView(
      //     slivers: [
      //       SliverList(
      //         delegate: SliverChildBuilderDelegate(
      //           childCount:
      //               tournametsData == null ? 0 : tournametsData.length,
      //           (context, index) {
      body: Container(
        // ignore: sort_child_properties_last
        child: ListView.builder(
          itemCount: tournametsData == null ? 0 : tournametsData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(19.0)),
                  Text(
                    "${tournametsData[index]["name"]}",
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(148, 255, 255, 255)),
                  ),
                ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          onPressed: () {
            print("Boton continuar");
            Routes(index: 1);
          },
          label: Row(
            children: [Text("SAVE"), Icon(Icons.arrow_right)],
          )),
    );
  }
}
