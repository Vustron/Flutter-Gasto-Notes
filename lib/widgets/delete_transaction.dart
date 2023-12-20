// ignore_for_file: sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../controller/api.dart';
import '../model/transaction.dart';
import '../model/user.dart';
import 'dialogs.dart';

class DeleteTransaction extends StatefulWidget {
  final Transactions transaction;
  final UserData user;
  const DeleteTransaction(
      {super.key, required this.user, required this.transaction});

  @override
  State<DeleteTransaction> createState() => _DeleteTransactionState();
}

class _DeleteTransactionState extends State<DeleteTransaction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // actions
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      try {
                        await API.deleteTransaction(
                          widget.user,
                          widget.transaction,
                          widget.transaction.amount,
                          widget.transaction.type,
                        );
                        Dialogs.showSuccessSnackbar(
                            context, 'Transaction deleted!');
                        Navigator.pop(context);
                      } catch (error) {
                        print(error);
                        Dialogs.showErrorSnackbar(
                            context, 'Transaction failed!');
                      }
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // _dialogController.reverse();

                      // hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
