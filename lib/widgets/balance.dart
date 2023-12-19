import 'package:flutter/material.dart';
import '../model/user.dart';

class Balance extends StatefulWidget {
  const Balance({super.key, required this.user});
  final UserData user;

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Balance:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          ' ₱${widget.user.balance}',
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.green),
        ),
      ],
    );
  }
}
