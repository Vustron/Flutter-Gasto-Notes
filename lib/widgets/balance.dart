import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'Balance:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          ' ₱20,000.00',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.green),
        ),
      ],
    );
  }
}
