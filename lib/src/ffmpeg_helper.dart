import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/log_callback.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/statistics_callback.dart';
import 'command.dart';

class VideoHelper {
  late String input;
  late Command _videoProps;
  VideoHelper({required this.input}) {
    _videoProps = Command()..inputPath = input;
  }

  execAsync(
      {FFmpegSessionCompleteCallback? completeCallback,
      LogCallback? logCallback,
      StatisticsCallback? statisticsCallback}) async {
    await FFmpegKit.executeAsync(_videoProps.toString(), completeCallback,
        logCallback, statisticsCallback);
  }

  Future<MediaInformation?> getMediaInfo(
      {String? inputPath, int? waitTimeout = 99999}) async {
    final i = inputPath ?? input;
    final session = await FFprobeKit.getMediaInformation(i, waitTimeout);
    final info = session.getMediaInformation();
    return info;
  }

  //视频开始和结束时间
  setVideoSliceTime(
      {required Duration startPoint, required Duration endPoint}) {
    _videoProps.cutByTime = '-ss $startPoint -t ${endPoint - startPoint}';
  }

  //文件输出路径
  setOutputPath(String outputPath) {
    _videoProps.outputPath = outputPath;
  }

  //图像缩放
  setVideoSale(int width, int height) {
    if (height == -1) {
      _videoProps.outputSize = "sale=$width:-1 ";
    } else if (width == -1) {
      _videoProps.outputSize = "sale=-1:$height ";
    } else {
      _videoProps.outputSize = "-s ${width}x$height ";
    }
  }

  //视频帧率 帧率越大越流畅（24fps 30fps 60fps）
  setVideoFrameRate(int fps) {
    _videoProps.fps = "-r $fps";
  }

  //-b 指定编码率，码率越大，体积越大，越清晰
  setVideoBitRate(double bitRate) {
    _videoProps.bitRate = "-b:v ${bitRate}k";
  }

  //视频编码器
  setVideoCodec(String codec) {
    _videoProps.codec = '-c:v $codec';
  }

  //-crf控制图像的质量，取值0（无损）-51 （质量最差） 默认是22 ，一般用的是19-28
  setVideoCrf(int crf) {
    _videoProps.crf = "-crf ${crf}";
  }

  setVideoFilename(String name) {
    _videoProps.name = name;
  }

  setVideoFormat(String format) {
    _videoProps.format = '-f $format';
  }

  setDisableVideo() {
    _videoProps.disabledVideo = true;
  }

  setDisableAudio() {
    _videoProps.disabledAudio = true;
  }
}
