// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasto_notes/model/user.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../controller/api.dart';
import '../controller/googleAuth.dart';
import '../main.dart';
import '../widgets/dialogs.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
          body: Container(
            height: 800,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),

            // form
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Space
                      SizedBox(width: mq.width, height: mq.height * .03),

                      Stack(
                        children: [
                          // User Profile Picture
                          _image != null
                              ?
                              // local image
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(mq.height * .1),
                                  child: Image.file(
                                    File(_image!),
                                    width: mq.height * .2,
                                    height: mq.height * .2,
                                    fit: BoxFit.cover,
                                  ))
                              :
                              // image from server
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(mq.height * .1),
                                  child: CachedNetworkImage(
                                    width: mq.height * .2,
                                    height: mq.height * .2,
                                    fit: BoxFit.fill,
                                    imageUrl: API.me.image,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                          // Edit image button
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: MaterialButton(
                              elevation: 1,
                              onPressed: () {
                                _showBottomSheet();
                              },
                              shape: const CircleBorder(),
                              color: const Color.fromARGB(255, 68, 255, 196),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Space
                      SizedBox(height: mq.height * .03),
                      // User Email
                      Text(
                        API.me.email,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      // Space
                      SizedBox(height: mq.height * .05),
                      // User Name
                      TextFormField(
                        initialValue: API.me.name,
                        onSaved: (val) => API.me.name = val ?? '',
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : 'Required Field',
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'eg. John Doe',
                          labelText: 'Name',
                        ),
                      ),
                      // Space
                      SizedBox(height: mq.height * .02),
                      // User about
                      TextFormField(
                        initialValue: API.me.about,
                        onSaved: (val) => API.me.about = val ?? '',
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : 'Required Field',
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'eg. Feeling Happy',
                          labelText: 'About',
                        ),
                      ),
                      // Space
                      SizedBox(height: mq.height * .04),
                      // Update Button
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await API.updateUserInfo();
                            Dialogs.showSuccessSnackbar(
                                context, 'Profile Updated Sucessfully');
                          }
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 28,
                        ),
                        label: const Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor:
                              const Color.fromARGB(255, 68, 255, 196),
                          minimumSize: Size(mq.width * .5, mq.height * .06),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .1),
            children: [
              // pick profile picture label
              const Text(
                'Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              // for adding some space
              SizedBox(height: mq.height * .04),
              // buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // pick from gallery button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(mq.width * .3, mq.height * .15),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 80);
                      if (image != null) {
                        print('Image Path: ${image.path}');
                        setState(() {
                          _image = image.path;
                        });

                        await API.updateUserProfilePicture(File(_image!));
                        // for hiding bottom sheet
                        Navigator.pop(context);
                        Dialogs.showSuccessSnackbar(
                            context, 'Picture Updated Sucessfully');
                      }
                    },
                    child: Image.asset('assets/images/add_image.png'),
                  ),
                  // take a picture from camera
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(mq.width * .3, mq.height * .15),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 80);
                      if (image != null) {
                        print('Image Path: ${image.path}');
                        setState(() {
                          _image = image.path;
                        });

                        await API.updateUserProfilePicture(File(_image!));
                        // for hiding bottom sheet
                        Navigator.pop(context);
                        Dialogs.showSuccessSnackbar(
                            context, 'Picture Updated Sucessfully');
                      }
                    },
                    child: Image.asset('assets/images/camera.png'),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
