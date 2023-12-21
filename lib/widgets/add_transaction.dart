// ignore_for_file: sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../controller/api.dart';
import '../screens/home_screen.dart';
import 'dialogs.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  // init form key
  final _formKey = GlobalKey<FormState>();
  // init title controller
  final titleController = TextEditingController();
  // init amount controller
  final amountController = TextEditingController();
  // init date controller
  final dateController = TextEditingController();
  // init type controller
  final typeController = TextEditingController();
  // category controller
  final categoryController = TextEditingController();
  // init title
  String title = '';
  // init amount
  double? amount = 0.00;
  // init date picker
  DateTime? pickedDate;
  // type
  String currentOption = 'Expense';
  // category
  String dropdownValue = 'Others';

  @override
  Widget build(BuildContext context) {
    final options = ['Expense', 'Income'];
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // title
          Expanded(
            child: TextFormField(
              maxLines: 1,
              controller: titleController,
              onChanged: (value) => title = value,
              validator: (value) => value!.isEmpty ? "Enter a title" : null,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'e.g. Pamasahe',
                hintStyle: const TextStyle(color: Colors.black38),
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

          // space
          const SizedBox(height: 20),

          // amount
          Expanded(
            child: TextFormField(
              maxLines: 1,
              controller: amountController,
              onChanged: (value) {
                double parsedValue = double.tryParse(value) ?? 0.0;
                if (parsedValue > 0 && parsedValue <= 1000000) {
                  setState(() {
                    amount = parsedValue;
                  });
                } else {
                  setState(() {
                    amountController.text = '';
                  });
                }
              },
              validator: (value) => value!.isEmpty ? "Enter an amount" : null,
              style: const TextStyle(color: Colors.black),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                LengthLimitingTextInputFormatter(
                    10), // Limit the input to 10 characters
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
                hintText: 'e.g. ₱ 20.00',
                hintStyle: const TextStyle(color: Colors.black38),
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
          ),

          // space
          const SizedBox(height: 18),

          // date
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
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
                validator: (value) => value!.isEmpty ? "Enter date" : null,
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
          ),

          Expanded(
            child: DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>[
                'Utilities',
                'Transportation',
                'Food',
                'Others',
                'Housing',
                'Taxes',
                'Repairs',
                'Healthcare',
                'Insurance',
                'Supplies',
                'Personal',
                'Work',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 15.4),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
          ),

          // category
          Expanded(
            child: Row(
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
          ),

          // actions
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String formattedDate =
                            DateFormat('MM/dd/yyyy').format(pickedDate!);
                        try {
                          await API.addingTransaction(
                            API.me,
                            title,
                            amount!,
                            formattedDate,
                            dropdownValue,
                            currentOption,
                          );

                          Dialogs.showSuccessSnackbar(
                              context, 'Transaction added!');
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: const HomeScreen(),
                              ));
                        } catch (error) {
                          print(error);
                          Dialogs.showErrorSnackbar(
                              context, 'Transaction failed!');
                          Navigator.pop(context);
                        }
                      }
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
                    onPressed: () async {
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
      ),
    );
  }
}
