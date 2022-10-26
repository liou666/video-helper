import 'package:flutter/material.dart';

class FfmpegPage extends StatefulWidget {
  static const name = 'FfmpegPage';
  const FfmpegPage({Key? key}) : super(key: key);
  @override
  State<FfmpegPage> createState() => _FfmpegPageState();
}

class _FfmpegPageState extends State<FfmpegPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('FfmpegPage'),
      ),
    );
  }
}
