import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/images.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/icon_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var mainBloc = Provider.of<MainBloc>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Builder(
          builder: (context) {
            switch (mainBloc.index) {
              case 0:
                return Container();
              case 1:
                return Container();
              default:
                return Container();
            }
          },
        ),
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () async {},
            child: Image.asset(Images.add, width: 50),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 33,
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
                      const Spacer(),
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
