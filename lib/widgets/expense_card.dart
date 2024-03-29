// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../model/user.dart';
import '../utils/display_util.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({super.key, required this.user});
  final UserData user;

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Card(
        child: Container(
          color: Colors.redAccent,
          width: 160,
          height: 100,
          child: Center(
            child: ListTile(
              // icons
              leading: const Icon(
                BoxIcons.bx_arrow_to_bottom,
                size: 30,
                color: Colors.white,
              ),

              // label
              title: const Text(
                'Expenses',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),

              // expenses
              subtitle: Text(
                DisplayUtil().getDisplayAmount(widget.user.expenses),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
