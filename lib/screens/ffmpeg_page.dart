import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'video_page.dart';

class FfmpegPage extends StatefulWidget {
  static const name = 'FfmpegPage';
  const FfmpegPage({Key? key}) : super(key: key);
  @override
  State<FfmpegPage> createState() => _FfmpegPageState();
}

class _FfmpegPageState extends State<FfmpegPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                final tempPath = await getTemporaryDirectory();
                debugPrint('tempath: ${File(tempPath.path).existsSync()}');
                final output = '${tempPath.path}/a.mp4';
                debugPrint('output: $output');

                const startPoint =  Duration(milliseconds: 10000);
                const endPoint =  Duration(milliseconds: 16000);

                final comment =
                    '-ss $startPoint -i http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4 -t ${endPoint - startPoint} -c:a copy $output -y  -hide_banner';
                await FFmpegKit.executeAsync(comment, (session) async {
                  final returnCode = await session.getReturnCode();

                  if (ReturnCode.isSuccess(returnCode)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) {
                        return VideoPage(filePath: File(output));
                      }),
                    );
                    debugPrint('success');
                    final log = await session.getAllLogsAsString();
                  } else if (ReturnCode.isCancel(returnCode)) {
                    debugPrint('cancel');
                  } else {
                    debugPrint('error');
                    final log = await session.getAllLogsAsString();
                  }
                }, (logs) {
                  // debugPrint(logs)
                });

              },
              child: const Text('run')),
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
//获取视频信息·
getMediaInfo(String input)async {
  final session= await FFprobeKit.getMediaInformation(input);
  final info=  session.getMediaInformation();
  print('getDuration: ${session.getDuration()}');
  print('info.getDuration: ${info?.getDuration()}');
  print('info.getFormat: ${info?.getFormat()}');
  print('info.getStartTime: ${info?.getStartTime()}');
  print('info.getFilename: ${info?.getFilename()}');
  print('info.getSize: ${info?.getSize()}');
  print('info.getBitrate: ${info?.getBitrate()}');
  return info;
}