import 'package:flutter/material.dart';
import 'screens/ffmpeg_page.dart';
import 'screens/video_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: VideoPage.name,
      routes: {
        FfmpegPage.name: (context) => const FfmpegPage(),
        VideoPage.name: (context) => const VideoPage(),
      },
    );
  }
}
