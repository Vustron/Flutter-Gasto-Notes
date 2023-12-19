import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../main.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 0.5,
      color: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const ListTile(
        // icon
        leading: Icon(
          FontAwesome.van_shuttle_solid,
          color: Colors.white,
          size: 35,
        ),

        // title
        title: Text(
          'Transportation',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Colors.white,
          ),
        ),

        // Last message
        subtitle: Text(
          '₱200.00',
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),

        // date
        trailing: Text(
          'Jan 2, 2023',
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
