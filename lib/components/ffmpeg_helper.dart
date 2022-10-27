import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/log_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information_session.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/session.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/session_state.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/statistics_callback.dart';
import 'comment_props.dart';
class FfmpegHelper{
  late String input;
  late VideoAttribute _videoProps;
  FfmpegHelper({required this.input}){
    _videoProps= VideoAttribute()..inputPath=input;
  }

  execAsync({
    FFmpegSessionCompleteCallback? completeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback})async{
    await FFmpegKit.executeAsync(_videoProps.toString(),completeCallback,logCallback,statisticsCallback);
  }

  Future<MediaInformationSession>getMediaInfo({String? inputPath,
    int? waitTimeout })async {
     final i = inputPath??input;
     return await FFprobeKit.getMediaInformation(i,waitTimeout);
  }


  setVideoSlice({required Duration startPoint,required Duration endPoint}){
    _videoProps.cutByTime='-ss $startPoint -t ${endPoint-startPoint}';
  }

  setOutputPath(String outputPath) {
    _videoProps.outputPath = outputPath;
  }

  setOutputVideoSale(int width, int height) {
    if (height == -1) {
      _videoProps.outputSize = "sale=$width:-1 ";
    } else if (width == -1) {
      _videoProps.outputSize = "sale=-1:$height ";
    } else {
      _videoProps.outputSize = "-s ${width}x$height ";
    }
  }


}