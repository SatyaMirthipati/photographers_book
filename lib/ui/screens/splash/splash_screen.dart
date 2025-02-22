import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../data/local/shared_prefs.dart';
import '../../../resources/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showImage = false;

  void checks() async {
    final navigator = Navigator.of(context);
    var userBloc = Provider.of<UserBloc>(context, listen: false);

    await Future.delayed(
      const Duration(seconds: 1),
      () => setState(() => _showImage = true),
    );
    await Future.delayed(const Duration(seconds: 3));

    var token = await Prefs.getToken();
    if (token == null) {
      navigator.pushNamedAndRemoveUntil(Routes.login, (route) => false);
    } else {
      await userBloc.getProfile();
      navigator.pushNamedAndRemoveUntil(Routes.main, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.55,
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 900),
            alignment: _showImage ? Alignment.center : Alignment.bottomCenter,
            child: Image.asset(Images.logo),
          ),
        ),
      ),
    );
  }
}
