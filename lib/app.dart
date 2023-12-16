import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';

import 'bloc/main_bloc.dart';
import 'bloc/progress_bloc.dart';
import 'bloc/user_bloc.dart';
import 'config/application.dart';
import 'config/routes.dart';
import 'resources/theme.dart';
import 'ui/widgets/progress_block_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  App({super.key}) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressBloc()),
          ChangeNotifierProvider(create: (_) => MainBloc()),
          ChangeNotifierProvider(create: (_) => UserBloc()),
        ],
        child: ProgressBlockWidget(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Photographers Book',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            onGenerateRoute: Application.router?.generator,
          ),
        ),
      ),
    );
  }
}
