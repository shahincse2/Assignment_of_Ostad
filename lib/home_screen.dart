import 'package:assignment_of_ostad/desktop_screen.dart';
import 'package:assignment_of_ostad/tablet_screen.dart';
import 'package:assignment_of_ostad/mobile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width <= 640) {
      return const MobileScreen();
    } else if (width > 640 && width < 1007) {
      return const TabletScreen();
    } else {
      return const DesktopScreen();
    }
  }
}
