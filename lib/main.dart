import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Reproducir Opus')),
        body: AudioPlayerWidget(),
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Carga y reproduce el archivo Opus desde la URL proporcionada
    player.setUrl(
        "https://firebasestorage.googleapis.com/v0/b/meditapp-b0787.appspot.com/o/1.opus?alt=media&token=65002a5b-f213-47c0-b133-9f468f1d3ee4");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => player.play(),
        child: Text("Reproducir Opus"),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
