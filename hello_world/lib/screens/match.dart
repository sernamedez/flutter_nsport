import 'package:flutter/material.dart';
import 'package:hello_world/widgets/navigator/BottonNavigator.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

class MatchScreen extends StatefulWidget {
  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  late VideoPlayerController _videoControl;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _videoControl = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    _initializeVideoPlayerFuture = _videoControl.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _videoControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("En vivo"),
      ),
      body: Container(
        // ignore: sort_child_properties_last
        child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _videoControl.value.aspectRatio,
                  child: VideoPlayer(_videoControl),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/a.png"),
          fit: BoxFit.cover,
        )),
      ),
      //// Desde aqui
      // body: YoYoPlayer(
      //   aspectRatio: 16 / 9,
      //   //url ( .m3u8 video streaming link )
      //   //example ( url :"https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8" )
      //   //example ( url :"https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101" )
      //   url: "https://s4.flowerscast.com:999/hls/extremotvhuawei.m3u8",
      //   // videoStyle: VideoStyle(),
      //   // videoLoadingStyle: VideoLoadingStyle(
      //   //   loading: Center(
      //   //     child: Text("Loading video"),
      // ),
      // // ),
      // // subtitle ( ...srt subtitle link )
      // // example ( subtitle:"https://eboxmovie.sgp1.digitaloceanspaces.com/mmmmtest.srt")
      // // subtitle: "",
      // // subtitle style
      // // subtitleStyle: SubtitleStyle(),
      // // ),
      // drawer: const DrawerBotton(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          _videoControl.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: () {
          print("Se toco el boton");
          setState(() {
            if (_videoControl.value.isPlaying) {
              _videoControl.pause();
            } else {
              _videoControl.play();
            }
          });
        },
      ),
      // bottomNavigationBar: const BottonNavigator(),
    );
  }
}
