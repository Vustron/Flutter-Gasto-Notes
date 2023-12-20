// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../model/user.dart';
import '../utils/display_util.dart';

class IncomeCard extends StatefulWidget {
  const IncomeCard({super.key, required this.user});
  final UserData user;

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Card(
        child: Container(
          color: Colors.green,
          width: 160,
          height: 100,
          child: Center(
            child: ListTile(
              leading: const Icon(
                BoxIcons.bx_arrow_to_top,
                size: 30,
                color: Colors.white,
              ),
              title: const Text(
                'Income',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                DisplayUtil().getDisplayAmount(widget.user.income),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
