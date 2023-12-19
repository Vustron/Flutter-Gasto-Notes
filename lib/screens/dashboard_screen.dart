// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gasto_notes/widgets/add_transaction.dart';
import 'package:icons_plus/icons_plus.dart';
import '../controller/api.dart';
import '../model/transaction.dart';
import '../model/user.dart';
import '../widgets/balance.dart';
import '../widgets/expense_card.dart';
import '../widgets/income_card.dart';
import '../widgets/transaction_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.user});

  final UserData user;

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen>
    with TickerProviderStateMixin {
  // for animations
  late AnimationController _dialogController;
  // For storing all users
  List<Transactions> _list = [];
  // Declare a stream variable
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;

  @override
  void initState() {
    super.initState();

    // dialog control animation
    _dialogController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Assign the stream variable to the firebase collection snapshots stream
    _stream = API.getAllTransactions(widget.user);
  }

  // Define a function that returns a Future<void> and updates the stream variable
  Future<void> _refreshData() async {
    setState(() {
      _stream = API.getAllTransactions(widget.user);
    });
  }

  @override
  void dispose() {
    // dispose dialog controller
    _dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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

          body: StreamBuilder(
            stream: API.getAllTransactions(widget.user),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                // If data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Color.fromARGB(255, 68, 255, 196),
                      size: 50.0,
                    ),
                  );

                // If some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  // log('Data: ${jsonEncode(data![0].data())}');
                  _list = data
                          ?.map((e) => Transactions.fromJson(e.data()))
                          .toList() ??
                      [];
                  if (_list.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: _refreshData,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                IncomeCard(user: widget.user),
                                ExpenseCard(user: widget.user),
                              ],
                            ),
                          ),

                          // Balance
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 0, bottom: 10),
                              child: Balance(user: widget.user),
                            ),
                          ),
                          // list of transactions
                          Expanded(
                            child: ListView.builder(
                              itemCount: _list.length,
                              reverse: false,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 75,
                                  child: TransactionCard(
                                    transaction: _list[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Transactions yet',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
              }
            },
          ),
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
              height: 400,
              child: const AddTransaction(),
            ),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }
}
