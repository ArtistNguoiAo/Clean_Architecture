import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risky_coin/presentation/screen/product_screen/product_screen.dart';
import 'package:risky_coin/presentation/screen/user_screen/user_screen.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  final List<Widget> _screens = [
    const ProductScreen(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.database),
            title: const Text("Local Database"),
            selectedColor: ColorUtils.primaryColor,
          ),

          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.fire),
            title: const Text("Firebase"),
            selectedColor: ColorUtils.primaryColor,
          ),
        ],
      ),
    );
  }
}

