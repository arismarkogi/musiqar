import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  static AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> play() async {
<<<<<<< HEAD
    await _audioPlayer.play(AssetSource('Blue.mp3'));
=======
    //await _audioPlayer.play('assets/Blue.mp3', isLocal: true);
    await _audioPlayer.play(AssetSource('Blue.mp3'));

>>>>>>> 3d15553 (update)
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
<<<<<<< HEAD
        child: Text('music page content'),
=======
        child: Text('Your music page content'),
>>>>>>> 3d15553 (update)
      ),
    );
  }
}
