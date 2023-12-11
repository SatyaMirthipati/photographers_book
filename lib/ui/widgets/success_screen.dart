import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/images.dart';

class SuccessScreen extends StatefulWidget {
  final String text;
  final VoidCallback onProcess;

  const SuccessScreen({super.key, required this.text, required this.onProcess});

  static Future open(
    BuildContext context, {
    required String text,
    required VoidCallback onProcess,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SuccessScreen(text: text, onProcess: onProcess),
      ),
    );
  }

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2, milliseconds: 190),
      () => widget.onProcess(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Spacer(),
            FractionallySizedBox(
              widthFactor: 0.55,
              child: Lottie.asset(Images.success),
            ),
            const SizedBox(height: 40),
            Text(
              widget.text,
              style: textTheme.titleMedium!.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
