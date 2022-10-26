import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  static const name = 'VideoPage';
  const VideoPage({Key? key}) : super(key: key);
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('videopage'),
      ),
    );
  }
}
