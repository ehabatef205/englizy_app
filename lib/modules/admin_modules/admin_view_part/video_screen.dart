import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String video;
  const VideoScreen({required this.video, super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ChewieController? chewieController;

  void createChewieController(String path) {
    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(path)),
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      showOptions: true,
    );
  }

  @override
  void initState() {
    super.initState();
    createChewieController(widget.video);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController!,
    );
  }
}
