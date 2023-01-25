import 'package:flutter/material.dart';
import 'package:hello_world/screens/match.dart';
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
      body: Container(
        // ignore: sort_child_properties_last
        child: ListView.builder(
          itemCount: tournametsData == null ? 0 : tournametsData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor:
                            const Color.fromARGB(99, 158, 158, 158),
                        // backgroundImage:
                        //     NetworkImage("${tournametsData[index]["img"]}"),

                        child: ClipOval(
                            child: Image.network(
                          "${tournametsData[index]["img"]}",
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        )),
                        // backgroundImage:
                        //     NetworkImage("${tournametsData[index]["img"]}"),
                      ),
                    ],
                  ),
                  title: Text(
                    "${tournametsData[index]["game"]}",
                    // textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12.7,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(164, 255, 255, 255)),
                  ),
                  subtitle: Text(
                    "${tournametsData[index]["tournament"]}",
                    style: const TextStyle(
                        color: Color.fromARGB(66, 255, 255, 255)),
                  ),
                  trailing: const Icon(Icons.live_tv),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MatchScreen()));
                    print("${tournametsData[index]["game"]}");
                  },
                  iconColor: Colors.orange,
                )
                // child: Center(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       CircleAvatar(
                //         radius: 23,
                //         backgroundColor: Color.fromARGB(99, 158, 158, 158),
                //         backgroundImage:
                //             NetworkImage("${tournametsData[index]["img"]}"),
                //       ),
                //       Text(
                //         "${tournametsData[index]["game"]}",
                //         // textAlign: TextAlign.center,
                //         style: const TextStyle(
                //             fontSize: 12.7,
                //             fontWeight: FontWeight.w800,
                //             color: Color.fromARGB(164, 255, 255, 255)),
                //       ),
                //       IconButton(
                //         padding: EdgeInsets.zero,
                //         // constraints: BoxConstraints(),
                //         onPressed: () {
                //           print(tournametsData[index]);
                //         },
                //         icon: const Icon(Icons.tv),
                //         color: Colors.orange,
                //       ),
                //     ],
                //   ),
                // ),
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
