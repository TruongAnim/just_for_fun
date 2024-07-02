import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_subtitle/flutter_subtitle.dart' hide Subtitle;
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  State createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  ChewieController? _chewieController;
  late SubtitleController _subtitleController;

  @override
  void initState() {
    getWebVtt();
    super.initState();
  }

  getWebVtt() async {
    // https://cc.zorores.com/20/2e/202eaab6dff289a5976399077449654e/eng-2.vtt
    // https://ohplayer.netlify.app/%E5%90%9B%E3%81%AE%E5%90%8D%E3%81%AF.srt

    final body = utf8.decode((await http.get(Uri.parse(
            'https://gist.githubusercontent.com/matibzurovski/d690d5c14acbaa399e7f0829f9d6888e/raw/63578ca30e7430be1fa4942d4d8dd599f78151c7/example.srt')))
        .bodyBytes);

    _subtitleController =
        SubtitleController.string(body, format: SubtitleFormat.srt);
    final controller = VideoPlayerController.network(
      'https://gcdn.dramashort.tv/videos/8f39f07c03b65461a5dfed9867c3165a/index.m3u8',
    );

    await controller.initialize();

    controller.addListener(() {
      setState(() {});
    });

    _chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
      subtitleBuilder: (context, subtitle) {
        return IgnorePointer(
          child: SubtitleView(
            text: subtitle,
            subtitleStyle: SubtitleStyle(
              fontSize: _chewieController!.isFullScreen ? 20 : 16,
            ),
          ),
        );
      },
    );

    //// Chewie Subtitle
    _chewieController!.setSubtitle(
      _subtitleController.subtitles
          .map(
            (e) => Subtitle(
              index: e.number,
              start: Duration(milliseconds: e.start),
              end: Duration(milliseconds: e.end),
              text: e.text,
            ),
          )
          .toList(),
    );

    //// Caption
    // final webVTTCaptionFile = _subtitleController.subtitles
    //     .map((e) => Caption(
    //           number: e.number,
    //           start: Duration(milliseconds: e.start),
    //           end: Duration(milliseconds: e.end),
    //           text: e.text,
    //         ))
    //     .toList();

    // controller.setClosedCaptionFile(
    //     Future.value(MyWebVTTCaptionFile(webVTTCaptionFile)));

    controller.setClosedCaptionFile(Future.value(SubRipCaptionFile(body)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            _chewieController != null
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(controller: _chewieController!),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text('SubtitleControllView'),
            if (_chewieController != null)
              SubtitleControllView(
                subtitleController: _subtitleController,
                inMilliseconds: _chewieController!
                    .videoPlayerController.value.position.inMilliseconds,
              ),
            const SizedBox(height: 20),
            const Text('ClosedCaption'),
            if (_chewieController != null)
              ClosedCaption(
                text:
                    _chewieController!.videoPlayerController.value.caption.text,
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
  }
}

class MyWebVTTCaptionFile extends ClosedCaptionFile {
  MyWebVTTCaptionFile(this.captions);

  @override
  List<Caption> captions = [];
}
