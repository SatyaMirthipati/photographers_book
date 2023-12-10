import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../resources/colors.dart';
import '../../resources/images.dart';
import 'three_size_dot.dart';

class LoadingWidget extends StatelessWidget {
  final bool _scaffold;

  const LoadingWidget({super.key}) : _scaffold = false;

  const LoadingWidget.scaffold({super.key}) : _scaffold = true;

  @override
  Widget build(BuildContext context) {
    var child = Center(
      child: Lottie.asset(Images.loading, width: 120, height: 120),
    );
    if (_scaffold) {
      return Scaffold(
        appBar: AppBar(),
        body: child,
      );
    }
    return child;
  }
}
