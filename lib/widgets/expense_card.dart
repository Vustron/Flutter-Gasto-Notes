// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({super.key});

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
          child: const Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/diagram_down.png'),
                radius: 15, // Adjust the radius as needed
              ),
              title: Text(
                'Expenses',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                '₱50',
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
