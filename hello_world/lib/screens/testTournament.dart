import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/widgets/tournamentModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late dynamic x;
  // ignore: non_constant_identifier_names
  Future<List<TournametsModel>> getTournamets() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/tournamets.json");
    List mapData = jsonDecode(data);
    List<TournametsModel> tournaments = mapData
        .map((tournaments) => TournametsModel.fromJson(tournaments))
        .toList();
    x = tournaments;
    return tournaments;
  }

  // late Map data;
  // late List tournametsData = [];
  late int index;

  // getTournamets() async {
  //   http.Response response = await http
  //       .get(Uri.parse('http://127.0.0.1:3000/tournamets/tournamets-page'));
  //   data = json.decode(response.body);
  //   setState(() {
  //     tournametsData = data['data'];
  //   });
  // }

  @override
  void initState() {
    Future<List<TournametsModel>> tournaments = getTournamets();
    setState(() {
      index = 1;
    });
    super.initState();
  }

  // List<TournametsModel> tournaments = [
  //   TournametsModel("a", "Ligue 1", false),
  //   TournametsModel("https://media-3.api-sports.io/football/leagues/78.png",
  //       "Bundesliga", false),
  // ];
  // List<String> tournaments = [
  //   {
  //     'img': "a",
  //   }
  // ];
  List<TournametsModel> selectedTournaments = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(232, 0, 0, 0),
          title: const Text("Select your favorites",
              style: TextStyle(color: Colors.orange)),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/a.png"),
              fit: BoxFit.cover,
            )),
            child: FutureBuilder<List<TournametsModel>>(
                future: getTournamets(),
                builder: (context, data) {
                  if (data.hasData) {
                    List<TournametsModel> tournamets = data.data!;
                    return Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(tournamets.length,
                                ((index) {
                              return TournametItem(x[index].imageSearch,
                                  x[index].name, x[index].isSelected, index);
                            })

                                // itemCount: tournamets.length,
                                // itemBuilder: (context, index) {
                                //   print("este es el index: ${index}");
                                //   return TournametItem(
                                //       "${tournamets[index].imageSearch}",
                                //       "${tournamets[index].name}",
                                //       "${tournamets[index].selected}",
                                //       index);
                                // },
                                // tournaments == null ? 0 : tournaments.length,
                                // // itemBuilder: (BuildContext context, int index) {
                                // (index) {
                                //   return TournametItem(
                                //       tournaments[index].img,
                                //       tournaments[index].name,
                                //       tournaments[index].isSelected,
                                //       index);
                                // },
                                ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/a.png"),
                        fit: BoxFit.cover,
                      )),
                      child: const Text("Loading ..."),
                    );
                  }
                })),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selectedTournaments.isEmpty
            ? Container()
            : FloatingActionButton.extended(
                backgroundColor: Colors.orange,
                onPressed: () {
                  // http.post(Uri.parse("http://127.0.0.1:3000/tournamets/"), body: {
                  //   "list": tournaments,
                  // });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage(
                            personal: "selected",
                          )));
                },
                label: Row(
                    children: [Text("SAVE (${selectedTournaments.length})")])));
  }

  Widget TournametItem(String img, String name, bool isSelected, int index) {
    return Card(
        color: const Color.fromARGB(157, 158, 158, 158),
        child: Column(
          children: [
            ListTile(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(68)),
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      alignment: Alignment.center,
                      image: NetworkImage(img),
                      errorBuilder: (context, error, stackTrace) {
                        return Padding(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              // alignment: Alignment.center,
                              "assets/nof.PNG",
                              fit: BoxFit.contain,
                            ));
                      },
                    ),
                    isSelected
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.orange,
                          )
                        : const Icon(
                            Icons.check_circle_outline,
                            color: Colors.grey,
                          )
                  ]),

              // subtitle:
              //     Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              //   isSelected
              //       ? const Icon(
              //           Icons.check_circle,
              //           color: Colors.orange,
              //         )
              //       : const Icon(
              //           Icons.check_circle_outline,
              //           color: Colors.grey,
              //         )
              // ]),

              onTap: () {
                setState(() {
                  print(x.runtimeType);
                  print("INITIAL ${x[index].isSelected}");
                  // if (isSelected == "true") {
                  //   isSelected = "false";
                  //   print("ahora es ${isSelected}");
                  // } else if (isSelected == "false") {
                  //   isSelected = "true";
                  //   print("ahora es ${isSelected}");
                  // }

                  x[index].isSelected = !x[index].isSelected;
                  print("CHANGE ${x[index].isSelected}");

                  if (x[index].isSelected == true) {
                    selectedTournaments
                        .add(TournametsModel(name, img, isSelected));
                    print("AFTER ADD IN LIST ${x[index].isSelected}");
                  } else if (x[index].isSelected == false) {
                    selectedTournaments.removeWhere(
                        (element) => element.name == x[index].name);
                  } else {
                    // selectedTournaments
                    //     .removeWhere((element) => element == x[index].name);
                    print(name);
                  }
                });
              },
            ),
          ],
        ));
  }
}
