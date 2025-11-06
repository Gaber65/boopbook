import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:boopbook/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

/// Stateful widget to fetch and then display video content.
class VideoFileApp extends StatefulWidget {
  VideoFileApp({super.key, required this.video});
  File video;
  @override
  _VideoFileAppState createState() => _VideoFileAppState();
}

class _VideoFileAppState extends State<VideoFileApp> {
  VideoPlayerController? videoPlayerController;

  late ChewieController chewieController;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    if (widget.video == null) {
      videoPlayerController = VideoPlayerController.file(widget.video)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize().then((value) {});
    } else {
      videoPlayerController = VideoPlayerController.file(widget.video)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize();
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoInitialize: true,
      errorBuilder: (context, message) {
        return Center(
          child: Text(message),
        );
      },
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: (videoPlayerController == null)
          ? Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            )
          : videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController!.value.size.width /
                      videoPlayerController!.value.size.height,
                  child: Container(
                    color: Colors.black,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
    );
  }
}

/// Stateful widget to fetch and then display video content.
class VideoStringApp extends StatefulWidget {
  VideoStringApp({super.key, required this.video});
  String video;
  @override
  _VideoStringAppState createState() => _VideoStringAppState();
}

class _VideoStringAppState extends State<VideoStringApp> {
  late VideoPlayerController videoPlayerController;

  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
      widget.video,
    )..addListener(() => setState(() {}));
    videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      materialProgressColors: ChewieProgressColors(playedColor: PKColor),
      errorBuilder: (context, message) {
        return Center(
          child: Text(message),
        );
      },
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: (videoPlayerController == null)
          ? Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            )
          : videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController.value.size.width /
                      videoPlayerController.value.size.height,
                  child: Container(
                    color: Colors.black,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
    );
  }
}

class VideApp extends StatefulWidget {
  VideApp({super.key, required this.video, this.isPlaying});
  String video;
  bool? isPlaying;

  @override
  _VideAppState createState() => _VideAppState();
}

class _VideAppState extends State<VideApp> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video))
          ..initialize().then(
            (_) {
              setState(() {
                if (widget.isPlaying == true) {
                  videoPlayerController.play();
                }
              });
            },
          );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AspectRatio(
                aspectRatio: videoPlayerController.value.size.width /
                    videoPlayerController.value.size.height,
                child: Container(
                  color: Colors.black,
                  child: VideoPlayer(
                    videoPlayerController,
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    videoPlayerController.value.isPlaying
                        ? videoPlayerController.pause()
                        : videoPlayerController.play();
                  });
                },
                icon: Icon(
                  videoPlayerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                ),
              )
            ],
          )
        : FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade700,
              highlightColor: Colors.grey.shade600,
              child: SizedBox(
                height: 250,
                width: double.infinity,
              ),
            ),
          );
  }
}
