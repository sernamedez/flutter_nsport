import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    http.Response response = await http
        .get(Uri.parse('http://127.0.0.1:3000/tournamets/tournamets-page'));
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

  List<String> tournaments = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(232, 0, 0, 0),
        title: const Text("Select your favorites",
            style: TextStyle(color: Colors.orange)),
      ),
      endDrawer: const DrawerBotton(),

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
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            tournametsData == null ? 0 : tournametsData.length,
            (index) {
              return Card(
                color: const Color.fromARGB(157, 158, 158, 158),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(68)),
                // shadowColor: Colors.orange,
                elevation: 10.0,
                child: ListTile(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(68)),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        alignment: Alignment.center,
                        image: NetworkImage(
                            "${tournametsData[index]["imageSearch"]}"),
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/nof.PNG",
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                      Icon(
                        (tournametsData[index]["name"]) == "Serie A"
                            ? (Icons.check)
                            : (Icons.clear),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                  // leading: (tournametsData[index]["name"]) == "Serie A"
                  //     ? const Icon(
                  //         Icons.check,
                  //         color: Colors.orange,
                  //       )
                  //     : const Icon(
                  //         Icons.check,
                  //         color: Colors.grey,
                  //       ),

                  onTap: () {
                    dynamic torneo = "${tournametsData[index]["name"]}";
                    setState(() {});
                    tournaments.add(torneo);
                    print(tournaments);
                  },
                  // textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
        // ignore: sort_child_properties_last
        // child: ListView.builder(
        //   itemCount: tournametsData == null ? 0 : tournametsData.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Card(
        //       color: const Color.fromARGB(0, 0, 0, 0),
        //       child: ListTile(
        //         // const Padding(padding: EdgeInsets.all(19.0)),
        //         title: Text(
        //           "${tournametsData[index]["name"]}",
        //           style: const TextStyle(
        //               fontSize: 14.0,
        //               fontWeight: FontWeight.w800,
        //               color: Color.fromARGB(148, 255, 255, 255)),
        //         ),
        //         onTap: () {
        //           print("${tournametsData[index]["name"]}");
        //         },
        //       ),
        //     );
        //   },
        // ),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/a.png"),
          fit: BoxFit.cover,
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          onPressed: () {
            // http.post(Uri.parse("http://127.0.0.1:3000/tournamets/"), body: {
            //   "list": tournaments,
            // });
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "nsportTV")));
          },
          label: Row(
            children: const [Text("SAVE")],
          )),
    );
  }
}
