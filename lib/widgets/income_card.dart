// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

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
          color: Colors.greenAccent,
          width: 160,
          height: 100,
          child: const Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/diagram_up.png'),
                radius: 15, // Adjust the radius as needed
              ),
              title: Text(
                'Income',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14),
              ),
              subtitle: Text(
                '₱200',
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
