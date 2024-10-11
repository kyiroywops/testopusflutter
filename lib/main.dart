import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Reproducir Opus convertido')),
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
  String? convertedFilePath;

  @override
  void initState() {
    super.initState();
    _convertOpusToMp3();
  }

  Future<void> _convertOpusToMp3() async {
    // Define la URL del archivo Opus a convertir
    String opusUrl =
        "https://firebasestorage.googleapis.com/v0/b/meditapp-b0787.appspot.com/o/1.opus?alt=media&token=65002a5b-f213-47c0-b133-9f468f1d3ee4";

    // Obtener el directorio temporal para guardar el archivo convertido
    final directory = await getTemporaryDirectory();
    convertedFilePath = '${directory.path}/output.mp3';

    // Ejecuta la conversión con FFmpeg Kit
    await FFmpegKit.execute(
      
        '-i "$opusUrl" "${convertedFilePath!}"').then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        print("Conversión exitosa: $convertedFilePath");
        await player.setFilePath(convertedFilePath!);
      } else {
        print("Falló la conversión.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (convertedFilePath != null) {
            player.play();
          }
        },
        child: Text("Reproducir MP3 convertido"),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
