// ignore_for_file: use_build_context_synchronously, avoid_print, unused_import

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../controller/api.dart';
import '../../controller/googleAuth.dart';
import '../../widgets/dialogs.dart';
import '../home_screen.dart';
import '/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      // Check if the widget is mounted before calling setState
      if (mounted) {
        setState(() {
          _isAnimate = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text("Welcome to WeChat"),
        // ),
        body: Stack(children: [
          // app logo
          AnimatedPositioned(
              top: mq.height * .15,
              right: _isAnimate ? mq.width * .25 : -mq.width * .5,
              width: mq.width * .5,
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/images/icon.png')),

          // app name
          Positioned(
            bottom: mq.height * .38,
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
                ],
              ),
            ),
          ),

          // google login
          AnimatedPositioned(
            bottom: mq.height * 0.2,
            left: _isAnimate ? mq.width * 0.14 : -mq.width * .5,
            height: mq.height * 0.2,
            duration: const Duration(seconds: 1),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  Dialogs.showProgressBar(context);
                  try {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);

                    await provider.googleLogin();

                    if (await API.userExists()) {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: const HomeScreen(),
                          ));
                    } else {
                      await API.createUser().then((value) {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: const HomeScreen(),
                            ));
                      });
                    }
                  } catch (error) {
                    print('Error during Google login: $error');
                    Dialogs.showErrorSnackbar(
                        context, 'Something went wrong: $error');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  shape: const StadiumBorder(),
                  elevation: 1,
                ),
                icon: SizedBox(
                  width: mq.height * 0.05,
                  height: mq.height * 0.07,
                  child: Image.asset('assets/images/google.png'),
                ),
                label: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 19,
                    ),
                    children: [
                      TextSpan(text: 'Login with '),
                      TextSpan(
                        text: 'Google    ',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
