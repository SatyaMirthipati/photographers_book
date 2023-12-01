import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';

import '../../../bloc/progress_bloc.dart';
import 'loading_widget.dart';

class ProgressBlockWidget extends StatelessWidget {
  final Widget child;

  const ProgressBlockWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var progressBloc = Provider.of<ProgressBloc>(context);
    return PortalTarget(
      visible: progressBloc.progress,
      portalFollower: Container(
        color: Colors.black38,
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: LoadingWidget(),
        ),
      ),
      child: child,
    );
  }
}
