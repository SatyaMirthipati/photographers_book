import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/progress_bloc.dart';
import 'error_snackbar.dart';

typedef FutureVoidCallback = Future<void> Function();

class ProgressUtils {
  static Future<void> handleProgress(
    BuildContext context, {
    required FutureVoidCallback task,
    VoidCallback? onSuccess,
    ValueChanged? onFail,
  }) async {
    var progressBloc = Provider.of<ProgressBloc>(context, listen: false);
    if (progressBloc.progress) return;
    progressBloc.enableProgress();
    try {
      await task();
      if (onSuccess != null) onSuccess();
    } catch (e) {
      if (onFail == null) {
        ErrorSnackBar.show(context, e);
      } else {
        onFail(e);
      }
    }
    progressBloc.disableProgress();
  }
}

class ProgressButton extends StatefulWidget {
  final Function? onPressed;
  final Widget? progressWidget;
  final Widget child;
  final Color? color;
  final double? elevation;

  const ProgressButton({
    Key? key,
    required this.onPressed,
    this.color,
    required this.child,
    this.progressWidget,
    this.elevation,
  }) : super(key: key);

  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<ProgressButton> {
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    var progressBloc = Provider.of<ProgressBloc>(context, listen: false);
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.maxFinite, 40),
        ),
      ),
      onPressed: widget.onPressed == null
          ? null
          : () async {
              if (progress || progressBloc.progress) return;
              setState(() => progress = true);
              progressBloc.enableProgress();
              try {
                await widget.onPressed!();
              } catch (e) {
                try {
                  ErrorSnackBar.show(context, e);
                } catch (error) {
                  print(error);
                }
              }
              progressBloc.disableProgress();
              if (!mounted) return;
              setState(() => progress = false);
            },
      child: widget.child,
    );
  }
}
