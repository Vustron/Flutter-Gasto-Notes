// ignore_for_file: sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  // init date controller
  final dateController = TextEditingController();
  // init title
  String title = '';
  // init amount
  int? amount = 0;
  // init date picker
  DateTime? pickedDate;
  String currentOption = 'Expense';

  @override
  Widget build(BuildContext context) {
    final options = ['Expense', 'Income'];
    return Column(
      children: [
        // title
        TextFormField(
          maxLines: null,
          onChanged: (value) => title = value,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: const TextStyle(color: Colors.black),
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

        // space
        const SizedBox(height: 20),

        // amount
        TextFormField(
          maxLines: null,
          onChanged: (value) {
            amount = int.tryParse(value);
          },
          style: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            hintText: 'Amount',
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: const Icon(
              Bootstrap.cash_stack,
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

        // space
        const SizedBox(height: 20),

        // date
        Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            onTap: () async {
              // user can pick date
              pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('MM/dd/yyyy').format(pickedDate!);
                dateController.text = formattedDate;
                setState(() {});
              }
            },
            controller: dateController,
            decoration: InputDecoration(
              labelText: "Date",
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              filled: true,
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

        // space
        const SizedBox(height: 15),

        // category
        Row(
          children: [
            RadioMenuButton<String>(
              value: options[0],
              groupValue: currentOption,
              onChanged: (expense) {
                setState(() {
                  currentOption = expense!;
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  "Expense",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.4,
                  ),
                ),
              ),
            ),
            RadioMenuButton<String>(
              style: ButtonStyle(
                iconSize: MaterialStateProperty.all(20),
              ),
              value: options[1],
              groupValue: currentOption,
              onChanged: (income) {
                setState(() {
                  currentOption = income!;
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  "Income",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.4,
                  ),
                ),
              ),
            ),
          ],
        ),

        // actions
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                MaterialButton(
                  onPressed: () async {
                    print('$title, $amount, $pickedDate, $currentOption');
                    // hide alert dialog
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    // _dialogController.reverse();
                    // hide alert dialog
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}