// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import '../controller/api.dart';
import '../utils/color_randomizer.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'transactions_screen.dart';

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
  // init user
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    // get self info
    API.getSelfInfo();
  }

  // init navbar items
  final items = <Widget>[
    Icon(
      Bootstrap.clipboard_data,
      size: 35,
      color: Colors.black,
    ),
    Icon(
      Bootstrap.columns_gap,
      size: 35,
      color: Colors.black,
    ),
    Icon(
      Icons.person,
      size: 35,
      color: Colors.black,
    ),
  ];

  // init screens
  final screens = [
    TransactionScreen(),
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

          // bottom navbars
          bottomNavigationBar: CurvedNavigationBar(
            key: navigationKey,
            color: Colors.white,
            buttonBackgroundColor: ColorRandomizer.randomColor(),
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 500),
            animationCurve: Curves.linear,
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
