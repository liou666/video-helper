import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/log_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information_session.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/session.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/session_state.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/statistics_callback.dart';

class FfmpegBrain{
  final String inputPath;
  FfmpegBrain(this.inputPath);

  // MediaInformation mediaInfo;

   getMediaInformation()async{
     final session= await FFprobeKit.getMediaInformation(inputPath);
     final info=  session.getMediaInformation();

     // print(session.getLogsAsString());
     // mediaInfo=info;
     // print('getDuration: ${session.getDuration()}');
     // print('info.getDuration: ${info?.getDuration()}');
     // print('info.getFormat: ${info?.getFormat()}');
     // print('info.getStartTime: ${info?.getStartTime()}');
     // print('info.getFilename: ${info?.getFilename()}');
     // print('info.getSize: ${info?.getSize()}');
     // print('info.getBitrate: ${info?.getBitrate()}');

     return this;

  }

}

