import 'package:flutter/material.dart';

import 'progress_button.dart';

class NavbarButton extends StatelessWidget {
  final Function? onPressed;
  final Widget child;
  final Color? color;

  const NavbarButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      padding: const EdgeInsets.all(20),
      child: ProgressButton(onPressed: onPressed, child: child),
    );
  }
}
