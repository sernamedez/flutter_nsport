import 'package:flutter/material.dart';
import 'package:hello_world/widgets/navigator/BottonNavigator.dart';
import 'package:hello_world/widgets/DrawerBotton.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

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
        title: const Text("xxxxxx vs xxxxxx"),
      ),
      body: FutureBuilder(
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
      drawer: const DrawerBotton(),
      floatingActionButton: FloatingActionButton(
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
