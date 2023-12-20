import 'package:flutter/material.dart';
import '../controller/api.dart';
import '../model/user.dart';

class Balance extends StatefulWidget {
  const Balance({super.key, required this.user});
  final UserData user;

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  void initState() {
    super.initState();

    // Second call to get self info after a short delay
    Future.delayed(const Duration(milliseconds: 200), () async {
      if (!mounted) {
        setState(() {});
        await API.getBalance(widget.user).then((value) => API.getSelfInfo());
      }
    });
  }

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
