import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  static AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> play() async {
    await _audioPlayer.play(AssetSource('Blue.mp3'));
  }

  static Future<void> pause() async {
    await _audioPlayer.pause();
  }

  static Future<void> stop() async {
    await _audioPlayer.stop();
  }
}

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  void initState() {
    super.initState();
    BackgroundMusicPlayer.play();
  }

  @override
  void dispose() {
    BackgroundMusicPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Page'),
      ),
      body: Center(
        child: Text('music page content'),
      ),
    );
  }
}
