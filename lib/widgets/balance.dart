import 'package:flutter/material.dart';
import '../model/user.dart';
import '../utils/display_util.dart';

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
        // label
        const Text(
          'Balance:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),

        // balance
        Text(
          widget.user.balance >= 0
              ? DisplayUtil().getDisplayAmount(widget.user.balance)
              : DisplayUtil().getDisplayNegativeAmount(widget.user.balance),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: widget.user.balance < 0 ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
