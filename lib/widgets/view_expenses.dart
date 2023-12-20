// ignore_for_file: sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../model/user.dart';
import '../utils/display_util.dart';

class ViewExpenses extends StatefulWidget {
  final UserData user;
  const ViewExpenses({super.key, required this.user});

  @override
  State<ViewExpenses> createState() => _ViewExpensesState();
}

class _ViewExpensesState extends State<ViewExpenses> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // income
          Expanded(
            child: TextFormField(
              maxLines: null,
              readOnly: true,
              initialValue: DisplayUtil().formatAmount(widget.user.expenses),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Expenses',
                prefixIcon: const Icon(
                  BoxIcons.bx_money,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
