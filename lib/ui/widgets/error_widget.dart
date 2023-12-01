import 'package:flutter/material.dart';

import 'error_handling.dart';

class CustomErrorWidget extends StatelessWidget {
  final error;
  final bool _simple;
  final bool _scaffold;

  const CustomErrorWidget({Key? key, required this.error})
      : _simple = false,
        _scaffold = false,
        super(key: key);

  const CustomErrorWidget.simple({Key? key, required this.error})
      : _simple = true,
        _scaffold = false,
        super(key: key);

  const CustomErrorWidget.scaffold({Key? key, required this.error})
      : _simple = false,
        _scaffold = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_simple) {
      return Text(
        ErrorHandling.parseError(error),
        textAlign: TextAlign.center,
      );
    }
    var child = Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Text(
          ErrorHandling.parseError(error),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18,
              ),
        ),
      ),
    );
    if (_scaffold) return Scaffold(appBar: AppBar(), body: child);
    return child;
  }
}
