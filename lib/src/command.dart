
class Command {
  Command();

  String inputPath = "";

  String outputPath = "";

  String size = "";

  String imageType = "jpg";

  String fps = "";

  String cutByTime = "";

  int waitTimeOut = 999;

  String name = "";

  String bitRate = "";

  String outputSize = "";

  String addWaterMark = "";

  String crf="";

  String codec='';

  String format='';

  bool disabledVideo=false;
  bool disabledAudio=false;

  get _disabledVideo{
    return disabledVideo?'-vn':'';
  }

  get _disabledAudio{
    return disabledAudio?'-an':'';
  }

  String get outputFilePath {
    return "$outputPath/$name";
  }

  @override
  String toString() {
    return "-i $inputPath $codec $addWaterMark $_disabledVideo $_disabledAudio $fps $size $bitRate $cutByTime $crf $format $outputSize $outputFilePath -y";
  }
}