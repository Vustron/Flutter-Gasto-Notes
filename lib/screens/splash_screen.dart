// ignore_for_file: unused_import

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

// Splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      // Exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
      ));
      Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: const LoginScreen(),
          ));
      // if (API.auth.currentUser != null) {
      //   print('\nUser: ${API.auth.currentUser}');

      //   Navigator.pushReplacement(
      //       context,
      //       PageTransition(
      //         type: PageTransitionType.size,
      //         alignment: Alignment.bottomCenter,
      //         child: HomeScreen(),
      //       ));
      // } else {
      //   Navigator.pushReplacement(
      //       context,
      //       PageTransition(
      //         type: PageTransitionType.size,
      //         alignment: Alignment.bottomCenter,
      //         child: LoginScreen(),
      //       ));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: Stack(children: [
        // App Logo
        Positioned(
            top: mq.height * .25,
            right: mq.width * .25,
            width: mq.width * .5,
            // duration: const Duration(seconds: 1),
            child: Image.asset('assets/images/icon.png')),

        // App Text
        Positioned(
          bottom: mq.height * .28,
          width: mq.width,
          // duration: const Duration(seconds: 1),
          child: Center(
            child: Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Gasto Notes',
                      textStyle: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.w900),
                      colors: [
                        Colors.black,
                        Colors.grey,
                      ],
                    ),
                  ],
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Made by Vustron Vustronus',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 70),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const SpinKitThreeInOut(
                  color: Colors.grey,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
