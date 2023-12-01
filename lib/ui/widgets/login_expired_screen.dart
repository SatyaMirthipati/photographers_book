import 'package:flutter/material.dart';

import '../../app.dart';
import '../../config/routes.dart';
import '../../data/local/shared_prefs.dart';
import '../../resources/images.dart';
import 'custom_card.dart';

class LoginExpiredScreen extends StatelessWidget {
  const LoginExpiredScreen({Key? key}) : super(key: key);

  static Future open() async {
    await Future.delayed(const Duration());
    await Prefs.clearPrefs();
    const routeName = "/auth-expired";
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
        pageBuilder: (context, _, __) => const LoginExpiredScreen(),
        opaque: false,
        fullscreenDialog: true,
        settings: const RouteSettings(name: routeName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      'Your session has been expired.\nPlease auth again',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.root,
                          (_) => false,
                        );
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
