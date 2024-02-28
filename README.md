
# video_helper 🕹️

<p align="left">
<a href="./README.md">
English
</a>
/
<a href="./README_CN.md">
简体中文
</a>
</p>


VideoHelper is a utility package for handling video processing in Flutter projects. powered by `ffmpeg_kit_flutter_full_gpl` package to easily execute video processing operations such as cropping, scaling, adjusting frame rates, setting bitrates, and more.

## Usage

Create a VideoHelper instance and use method chaining to process videos

```dart
// Initialize VideoHelper with the video file path
VideoHelper VideoHelper = VideoHelper(input: '/video_file.mp4');

// Set the output path
VideoHelper.setOutputPath('/processed_video_directory');

// Set the start and end time of the video
VideoHelper.setVideoSliceTime(startPoint: Duration(seconds: 0), endPoint: Duration(seconds: 10));

// Set the video scale
VideoHelper.setVideoScale(1280, 720);

// Set the video frame rate
VideoHelper.setVideoFrameRate(30);

// Set the video bitrate
VideoHelper.setVideoBitRate(2000);

// Set the video codec
VideoHelper.setVideoCodec('h264');

// Set the video quality
VideoHelper.setVideoCrf(20);

// Set the video filename
VideoHelper.setVideoFilename('processed_video_file_name.mp4');

// Set the video output format (optional)
VideoHelper.setVideoFormat('mp4');

// Disable video
VideoHelper.setDisableVideo();

// Disable audio
VideoHelper.setDisableAudio();

// Execute the FFmpeg command asynchronously
await VideoHelper.execAsync(
  completeCallback: (session) {
    print('Processing completed!');
    // Callback function after processing is completed
  },
  logCallback: (log) {
    print('FFmpeg log: $log');
    // Callback function for FFmpeg logs
  },
  statisticsCallback: (statistics) {
    print('FFmpeg statistics: $statistics');
    // Callback function for FFmpeg statistics
  },
);

// Get the media information of the video file
MediaInformation? mediaInfo = await VideoHelper.getMediaInfo();

// Output the media information of the video file
if (mediaInfo != null) {
  print('Video duration: ${mediaInfo.getDuration()}');
  print('Video resolution: ${mediaInfo.getStreams()[0].getWidth()}x${mediaInfo.getStreams()[0].getHeight()}');
}
```
chaining to process videos👇
```dart
VideoHelper(input: 'video_file.mp4')
  ..setOutputPath('processed_video_directory') // set target directory
  ..setVideoFilename('processed_video_file_name.mp4') // set video name
  ..setVideoSliceTime( // slice
    startPoint: const Duration(seconds: 20),
    endPoint: const Duration(seconds: 30),
  )
  ..setDisableAudio(); // disabled audio

```

## LICENSE
The project use [MIT](./LICENSE) license
