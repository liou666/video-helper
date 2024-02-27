
# video_helper

Flutter VideoHelper 是一个用于在 Flutter 项目中处理视频文件的实用工具。它基于 ffmpeg_kit_flutter_full_gpl 包提供的功能，可以轻松地执行各种视频处理操作，如裁剪、缩放、调整帧率、设置比特率等。

## 使用方法

```dart
// 初始化 VideoHelper，传入视频文件路径
VideoHelper VideoHelper = VideoHelper(input: '/视频文件.mp4');

// 设置输出路径
VideoHelper.setOutputPath('/处理后视频的目录');

// 设置视频开始和结束时间
VideoHelper.setVideoSliceTime(startPoint: Duration(seconds: 0), endPoint: Duration(seconds: 10));

// 设置视频缩放
VideoHelper.setVideoSale(1280, 720);

// 设置视频帧率
VideoHelper.setVideoFrameRate(30);

// 设置视频比特率
VideoHelper.setVideoBitRate(2000);

// 设置视频编码器
VideoHelper.setVideoCodec('h264');

// 设置视频质量
VideoHelper.setVideoCrf(20);

// 设置视频文件名
VideoHelper.setVideoFilename('处理后的视频文件名.mp4');

// 设置视频输出格式（可选）
VideoHelper.setVideoFormat('mp4');

// 禁用视频
VideoHelper.setDisableVideo();

// 禁用音频
VideoHelper.setDisableAudio();

// 异步执行 FFmpeg 命令
await VideoHelper.execAsync(
  completeCallback: (session) {
    print('处理完成！');
    // 处理完成后的回调函数
  },
  logCallback: (log) {
    print('FFmpeg 日志：$log');
    // FFmpeg 日志的回调函数
  },
  statisticsCallback: (statistics) {
    print('FFmpeg 统计信息：$statistics');
    // FFmpeg 统计信息的回调函数
  },
);

// 获取视频文件的媒体信息
MediaInformation? mediaInfo = await VideoHelper.getMediaInfo();

// 输出视频文件的媒体信息
if (mediaInfo != null) {
  print('视频时长：${mediaInfo.getDuration()}');
  print('视频分辨率：${mediaInfo.getStreams()[0].getWidth()}x${mediaInfo.getStreams()[0].getHeight()}');
}

```
支持`..`语法链式调用
```dart
VideoHelper(input: '视频文件.mp4')
  ..setOutputPath('处理后视频的目录') // 设置输出路径
  ..setVideoFilename('处理后的视频文件名.mp4') // 设置视频文件名
  ..setVideoSliceTime( // 视频片段截取
    startPoint: const Duration(seconds: 20),
    endPoint: const Duration(seconds: 30),
  )
  ..setDisableAudio(); // 禁用音频

```

## LICENSE
本项目采用 [MIT](./LICENSE) 许可证
