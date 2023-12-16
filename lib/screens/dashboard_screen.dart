// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import '../widgets/expense_card.dart';
import '../widgets/income_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
            child: Row(
              children: [
                IncomeCard(),
                SizedBox(width: 5.0),
                ExpenseCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
