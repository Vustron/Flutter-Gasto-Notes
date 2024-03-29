import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../main.dart';
import '../model/transaction.dart';
import '../utils/icons_util.dart';
import '../utils/display_util.dart';

class TransactionCard extends StatefulWidget {
  final Transactions transaction;
  const TransactionCard({super.key, required this.transaction});

  // final Transactions transaction;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    String categoryName = widget.transaction.category;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 0.5,
      color: IconsUtil.getColorsForCategory(categoryName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        // icon
        leading: IconsUtil.getIconForCategory(categoryName),

        // title
        title: Row(
          children: [
            // icons for income or expense
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  widget.transaction.type == 'Income'
                      ? const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Icon(
                            BoxIcons.bx_arrow_to_top,
                            color: Colors.green,
                            size: 17,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Icon(
                            BoxIcons.bx_arrow_to_bottom,
                            color: Colors.red,
                            size: 17,
                          ),
                        ),
                ],
              ),
            ),

            Text(
              DisplayUtil().limitCharacters(widget.transaction.title, 8),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),

        // transaction amount
        subtitle: Text(
          DisplayUtil().getDisplayAmount(widget.transaction.amount),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),

        // date
        trailing: Text(
          widget.transaction.transactionDate,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
