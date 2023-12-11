import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' as f;
import 'package:photographers_book/ui/screens/auth/login_screen.dart';

import '../ui/screens/splash/splash_screen.dart';

extension MaterialFluro on FluroRouter {
  void defineMat(String path, Handler handler) {
    define(
      path,
      handler: handler,
      transitionType: TransitionType.material,
    );
  }
}

extension RouteString on String {
  String setId(String id) {
    return this.replaceFirst(':id', id);
  }
}

class Routes {
  static String root = '/';
  static String login = '/login';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;

    router.define(
      root,
      handler: rootHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.material,
    );
  }
}

var notFoundHandler = Handler(
  type: HandlerType.function,
  handlerFunc: (context, params) {
    var path = f.ModalRoute.of(context!)!.settings.name;
    return f.ErrorWidget('$path route was not found!');
  },
);

var rootHandler = Handler(handlerFunc: (c, p) => const SplashScreen());

var loginHandler = Handler(handlerFunc: (c, p) => const LoginScreen());

var demoHandler = Handler(handlerFunc: (context, params) => f.Container());
