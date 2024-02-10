import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/main_bloc.dart';
import '../../../config/routes.dart';
import '../../../resources/images.dart';
import '../home/home_screen.dart';
import '../sheets/sheets_screen.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/icon_widget.dart';
import 'widgets/profile_avatar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Sheets';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mainBloc = Provider.of<MainBloc>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          titleSpacing: 20,
          title: Text(getTitle(mainBloc.index)),
          actions: [
            ProfileAvatar(
              onTap: () => Navigator.pushNamed(context, Routes.profile),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Builder(
          builder: (context) {
            switch (mainBloc.index) {
              case 0:
                return const HomeScreen();
              case 1:
                return const SheetsScreen();
              default:
                return Container();
            }
          },
        ),
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () async {
              final navigator = Navigator.of(context);

              if (mainBloc.index == 0) {
              } else if (mainBloc.index == 1) {
                var res = await Navigator.pushNamed(
                  context,
                  Routes.createSheet,
                );
                if (res == null) return;
                navigator.pushNamedAndRemoveUntil(
                  Routes.main,
                  (route) => false,
                );
                mainBloc.updateIndex(1);
              }
            },
            child: Image.asset(Images.add, width: 50),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 50,
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomPaint(
                painter: BottomBarPainter(),
                child: const SafeArea(
                  top: false,
                  bottom: true,
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                  ),
                ),
              ),
              SafeArea(
                top: false,
                bottom: true,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconWidget(
                          text: 'Home',
                          image: Images.home,
                          selected: mainBloc.index == 0,
                          onTap: () {
                            setState(() => mainBloc.index = 0);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconWidget(
                          text: 'Sheets',
                          image: Images.sheet,
                          selected: mainBloc.index == 1,
                          onTap: () {
                            setState(() => mainBloc.index = 1);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
