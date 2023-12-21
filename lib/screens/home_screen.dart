// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gasto_notes/main.dart';
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

  @override
  void initState() {
    super.initState();

    setState(() {
      API.getSelfInfo();
    });

    // Second call to get self info after a short delay
    Future.delayed(Duration(milliseconds: 2000), () async {
      setState(() {});
      await API.getSelfInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    // init user
    User? user = FirebaseAuth.instance.currentUser;

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
      ClipRRect(
        borderRadius: BorderRadius.circular(mq.height * .1),
        child: CachedNetworkImage(
          width: mq.height * .06,
          height: mq.height * .06,
          fit: BoxFit.fill,
          imageUrl: API.me.image,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
      ),
    ];

    // init screens
    final screens = [
      TransactionScreen(user: API.me),
      DashboardScreen(user: API.me),
      ProfileScreen(user: API.me),
    ];

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
