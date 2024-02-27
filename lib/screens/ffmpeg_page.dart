import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'video_page.dart';
import 'package:video_helper/src/ffmpeg_helper.dart';

class FfmpegPage extends StatefulWidget {
  static const name = 'FfmpegPage';
  const FfmpegPage({Key? key}) : super(key: key);
  @override
  State<FfmpegPage> createState() => _FfmpegPageState();
}

class _FfmpegPageState extends State<FfmpegPage> {
  late VideoHelper ffmpeg;
  late Directory tempDirectory;
  String outputName = 'a.mp4';
  @override
  void initState() {
    super.initState();
    const input = 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4';
    getTemporaryDirectory().then((temp) {
      tempDirectory = temp;
      debugPrint('tempDirectory: ${File(tempDirectory.path).existsSync()}');
      ffmpeg = VideoHelper(input: input)
        ..setOutputPath(tempDirectory.path)
        ..setVideoFilename(outputName)
        ..setVideoSliceTime(
            startPoint: const Duration(seconds: 20),
            endPoint: const Duration(seconds: 30))
        ..setDisableAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                ffmpeg.execAsync(completeCallback: (session) async {
                  final command = session.getCommand();
                  debugPrint(command);
                  final returnCode = await session.getReturnCode();
                  if (ReturnCode.isSuccess(returnCode)) {
                    final output = '${tempDirectory.path}/$outputName';
                    debugPrint(output);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) {
                        return VideoPage(filePath: File(output));
                      }),
                    );
                    debugPrint('success');
                  } else if (ReturnCode.isCancel(returnCode)) {
                    debugPrint('cancel');
                  } else {
                    debugPrint('error');
                    final log = await session.getAllLogs();
                    for (var element in log) {
                      print(element.getMessage());
                    }
                  }
                });
              },
              child: const Text('run')),
          ElevatedButton(
            onPressed: () async {
              final info = await ffmpeg.getMediaInfo();
              debugPrint(info?.getBitrate());
            },
            child: const Text('getInfo'),
          )
        ],
      ),
    ));
  }
}

//获取处理进度
double getFFmpegProgress(String ffmpegLogs, num videoDurationInSec) {
  final regex = RegExp("(?<=time=)[\\d:.]*");
  final match = regex.firstMatch(ffmpegLogs);
  if (match != null) {
    final matchSplit = match.group(0).toString().split(":");
    if (videoDurationInSec != 0) {
      final progress = (int.parse(matchSplit[0]) * 3600 +
              int.parse(matchSplit[1]) * 60 +
              double.parse(matchSplit[2])) /
          videoDurationInSec;
      double showProgress = (progress * 100);
      return showProgress;
    }
  }
  return 0;
}
