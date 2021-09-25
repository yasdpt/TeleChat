import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoViewerDialog extends StatefulWidget {
  final String videoUrl;

  const VideoViewerDialog({
    Key key,
    @required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoViewerDialogState createState() => _VideoViewerDialogState();
}

class _VideoViewerDialogState extends State<VideoViewerDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Dismissible(
            key: Key('DissMissKey'),
            background: const Offstage(),
            direction: DismissDirection.vertical,
            resizeDuration: Duration(milliseconds: 1),
            onDismissed: (_) => Navigator.of(context).pop(),
            child: AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: BetterPlayer.file(
                widget.videoUrl,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  autoPlay: true,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
