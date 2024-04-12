import 'package:flutter/material.dart';

import '../../widgets/youtube_embeded_view.dart';

class HowItWorksScreen extends StatelessWidget {
  final String url;

  const HowItWorksScreen({Key? key, required this.url}) : super(key: key);

  static Future open(BuildContext context,{required String url}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HowItWorksScreen(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubeEmbeddedView(url: url),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 8,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                child: IconButton(
                  icon: Icon(Icons.close_rounded),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
