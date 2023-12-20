// ignore_for_file: sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import '../model/transaction.dart';
import '../utils/display_util.dart';

class ViewTransaction extends StatefulWidget {
  final Transactions transaction;
  const ViewTransaction({super.key, required this.transaction});

  @override
  State<ViewTransaction> createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // title
          Expanded(
            child: TextFormField(
              maxLines: null,
              readOnly: true,
              initialValue: widget.transaction.title,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Title',
                prefixIcon: const Icon(
                  BoxIcons.bx_comment_add,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // amount
          Expanded(
            child: TextFormField(
              maxLines: null,
              readOnly: true,
              initialValue:
                  DisplayUtil().formatAmount(widget.transaction.amount),
              style: const TextStyle(color: Colors.black),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final text = newValue.text;
                  return text.isEmpty
                      ? newValue
                      : double.tryParse(text) == null
                          ? oldValue
                          : newValue;
                }),
              ],
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: const Icon(
                  BoxIcons.bx_money,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          // date
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                initialValue: widget.transaction.transactionDate,
                decoration: InputDecoration(
                  labelText: "Date",
                  prefixIcon: const Icon(Icons.calendar_today),
                  prefixIconColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                readOnly: true,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // category
          Expanded(
            child: TextFormField(
              readOnly: true,
              initialValue: widget.transaction.type,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Type',
                prefixIcon: const Icon(
                  BoxIcons.bx_objects_horizontal_center,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // type
          Expanded(
            child: TextFormField(
              maxLines: null,
              readOnly: true,
              initialValue: widget.transaction.category,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Category',
                prefixIcon: const Icon(
                  BoxIcons.bx_category,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
