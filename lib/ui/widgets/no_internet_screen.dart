import 'package:flutter/material.dart';

import '../../app.dart';
import '../../resources/images.dart';
import 'custom_card.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  static Future open() async {
    await Future.delayed(const Duration());
    const routeName = "/no-internet";
    bool isNewRouteSameAsCurrent = false;
    navigatorKey.currentState?.popUntil((route) {
      if (route.settings.name == routeName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    if (isNewRouteSameAsCurrent) return;
    return navigatorKey.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => const NoInternetScreen(),
        opaque: false,
        fullscreenDialog: true,
        settings: const RouteSettings(name: routeName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(Images.logo, height: 160),
                    const SizedBox(height: 16),
                    Text(
                      'Unable to connect!\n'
                      'Please check your network and try again',
                      textAlign: TextAlign.center,
                      style: textTheme.labelSmall,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
