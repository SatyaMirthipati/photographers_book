import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeEmbeddedView extends StatefulWidget {
  final String url;

  const YoutubeEmbeddedView({Key? key, required this.url}) : super(key: key);

  @override
  YoutubeEmbeddedViewState createState() => YoutubeEmbeddedViewState();
}

class YoutubeEmbeddedViewState extends State<YoutubeEmbeddedView> {
  YoutubePlayerController? controller;
  bool mute = false;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.url,
        trimWhitespaces: true,
      )!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: mute,
        disableDragSeek: true,
        forceHD: true,
        loop: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    print('==?dad');
    print(widget.url);
    print(YoutubePlayer.convertUrlToId(widget.url));
    return YoutubePlayer(
      controller: controller!,
      bufferIndicator: const SizedBox.shrink(),
      onReady: () {
        controller?.setVolume(50);
      },
      topActions: [
        const Spacer(),
        if (mute)
          Container(
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(2),
            child: Text(
              'Tap to unmute',
              style: textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.black45,
          child: IconButton(
            icon: Icon(
              mute ? Icons.volume_off_rounded : Icons.volume_up_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              if (mute) {
                controller?.unMute();
              } else {
                controller?.mute();
              }
              mute = !mute;
              setState(() {});
            },
          ),
        )
      ],
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        RemainingDuration(),
      ],
    );
  }
}
