// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasto_notes/model/user.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../controller/api.dart';
import '../controller/googleAuth.dart';
import '../widgets/dialogs.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  // initialize user
  final UserData user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          // appbar
          appBar: AppBar(
            backgroundColor: Colors.grey,
            elevation: 0,
            centerTitle: true,
            // title
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Logout Button
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FloatingActionButton.extended(
              onPressed: () async {
                // for showing progress
                // EasyLoading.show(status: 'loading...');
                Dialogs.showProgressBar(context);
                try {
                  // Google provider and listener
                  final googleprovider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  await googleprovider.googleLogout().then((value) async {
                    // for moving to home screen
                    Navigator.pop(context);

                    API.auth = FirebaseAuth.instance;

                    // Replacing home screen with login screen
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.topToBottom,
                          child: const LoginScreen(),
                        ));
                    // EasyLoading.dismiss();
                    Dialogs.showSuccessSnackbar(
                        context, 'Logout successfully!');
                  });
                } catch (error) {
                  print('Error during Google login: $error');
                  Dialogs.showErrorSnackbar(
                      context, 'Something went wrong: $error');
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.redAccent,
            ),
          ),

          // body
          body: const Center(
            child: Text('Profile'),
          ),
        ),
      ),
    );
  }
}
