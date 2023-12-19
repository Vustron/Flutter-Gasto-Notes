// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:gasto_notes/widgets/add_transaction.dart';
import 'package:icons_plus/icons_plus.dart';
import '../widgets/balance.dart';
import '../widgets/expense_card.dart';
import '../widgets/income_card.dart';
import '../widgets/transaction_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen>
    with TickerProviderStateMixin {
  // for animations
  late AnimationController _dialogController;
  // init scroller controller

  @override
  void initState() {
    super.initState();

    // dialog control animation
    _dialogController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
      ),

      // Add transaction button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            _addTransaction();
          },
          backgroundColor: Colors.white70,
          child: const Icon(
            Bootstrap.cash_coin,
            color: Colors.black,
          ),
        ),
      ),

      // body
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  IncomeCard(),
                  ExpenseCard(),
                ],
              ),
            ),

            // Balance
            Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 25, top: 0, bottom: 10),
                child: Balance(),
              ),
            ),

            // list of transactions
            Expanded(
              child: Container(
                height: 242,
                child: ListView(
                  children: const [
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTransaction() {
    showDialog(
      context: context,
      builder: (_) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: _dialogController,
          curve: Curves.easeInOut,
        )),
        child: Material(
          type: MaterialType.transparency,
          child: AlertDialog(
            contentPadding:
                const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
            backgroundColor: Colors.white,
            title: const Row(
              children: [
                Icon(
                  BoxIcons.bx_money_withdraw,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' Add Transaction',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
              height: 350,
              child: const AddTransaction(),
            ),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }
}
