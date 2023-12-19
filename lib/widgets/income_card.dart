// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class IncomeCard extends StatefulWidget {
  const IncomeCard({super.key});

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
          child: const Center(
            child: ListTile(
              leading: Icon(
                BoxIcons.bx_line_chart,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Income',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14),
              ),
              subtitle: Text(
                '₱200.00',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
