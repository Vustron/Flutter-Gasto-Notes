// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class Dialogs {
  // error
  static void showErrorSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(239, 235, 15, 15),
      ),
    );
  }

  // success
  static void showSuccessSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(238, 70, 235, 15),
      ),
    );
  }

  // progress
  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(
          child: CircularProgressIndicator(
        color: Colors.grey,
      )),
    );
  }
}
