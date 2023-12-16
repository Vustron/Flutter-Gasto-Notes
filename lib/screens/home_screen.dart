// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // init navkey
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  // init key index
  int index = 1;

  // init navbar items
  final items = <Widget>[
    Icon(
      Icons.search,
      size: 35,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      size: 35,
      color: Colors.white,
    ),
    Icon(
      Icons.person,
      size: 35,
      color: Colors.white,
    ),
  ];

  // init screens
  final screens = [
    SearchScreen(),
    DashboardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,

          // body
          body: screens[index],

          // bottom navbar
          bottomNavigationBar: CurvedNavigationBar(
            key: navigationKey,
            color: Colors.grey,
            buttonBackgroundColor: Colors.grey,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 300),
            height: 60.0,
            index: index,
            items: items,
            onTap: (index) => setState(
              () => this.index = index,
            ),
          )),
    );
  }
}
