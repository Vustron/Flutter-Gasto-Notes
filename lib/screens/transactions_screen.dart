// ignore_for_file: sized_box_for_whitespace, deprecated_member_use, unused_element, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import '../controller/api.dart';
import '../model/transaction.dart';
import '../model/user.dart';
import '../widgets/add_transaction.dart';
import '../widgets/delete_transaction.dart';
import '../widgets/edit_transaction.dart';
import '../widgets/transaction_card.dart';
import '../widgets/view_balance.dart';
import '../widgets/view_expenses.dart';
import '../widgets/view_income.dart';
import '../widgets/view_transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key, required this.user});
  final UserData user;

  @override
  State<TransactionScreen> createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen>
    with TickerProviderStateMixin {
  // for animations
  late AnimationController _dialogController;
  // For storing all users
  List<Transactions> _list = [];
  // for storing search items
  final List<Transactions> _searchList = [];
  // Declare a stream variable
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    API.getSelfInfo();

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
      API.getSelfInfo();
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
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          }
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
            title: _isSearching
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Transaction name',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                    // Search logic
                    onChanged: (val) {
                      _searchList.clear();
                      for (var i in _list) {
                        if (i.title.toLowerCase().contains(val.toLowerCase()) ||
                            i.transactionDate
                                .toLowerCase()
                                .contains(val.toLowerCase())) {
                          _searchList.add(i);
                        }
                        setState(() {
                          _searchList;
                        });
                      }
                    },
                  )
                : const Text(
                    'Transactions',
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
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
              backgroundColor: Colors.white70,
              child: const Icon(
                Bootstrap.search,
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
                          // list of transactions
                          Expanded(
                            child: ListView.builder(
                              itemCount: _isSearching
                                  ? _searchList.length
                                  : _list.length,
                              reverse: false,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 75,
                                  child: InkWell(
                                    onTap: () {
                                      _viewTransaction(index);
                                    },
                                    child: Slidable(
                                      startActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (BuildContext context) =>
                                                _deleteTransaction(index),
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (BuildContext context) =>
                                                _editTransaction(index),
                                            backgroundColor: Colors.yellow,
                                            foregroundColor: Colors.white,
                                            icon: Icons.edit,
                                            label: 'Edit',
                                          ),
                                        ],
                                      ),
                                      child: TransactionCard(
                                        transaction: _isSearching
                                            ? _searchList[index]
                                            : _list[index],
                                      ),
                                    ),
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

  // add transaction
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

  // view transaction
  void _viewTransaction(index) {
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
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' View Transaction',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
                height: 520,
                child: ViewTransaction(
                  transaction: _list[index],
                )),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }

  // view income
  void _viewIncome() {
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
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' View Income',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
                height: 120,
                child: ViewIncome(
                  user: widget.user,
                )),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }

  // view expenses
  void _viewExpenses() {
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
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' View Expenses',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
                height: 120,
                child: ViewExpenses(
                  user: widget.user,
                )),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }

  // view expenses
  void _viewBalance() {
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
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' View Balance',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
                height: 120,
                child: ViewBalance(
                  user: widget.user,
                )),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }

  // add transaction
  void _editTransaction(index) {
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
                  BoxIcons.bx_edit,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' Edit Transaction',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
              height: 400,
              child: EditTransaction(
                transaction: _list[index],
              ),
            ),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }

  // view expenses
  void _deleteTransaction(index) {
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
                  BoxIcons.bx_trash,
                  color: Colors.black,
                  size: 28,
                ),
                Text(
                  ' Delete Transaction',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            content: Container(
                height: 70,
                child: DeleteTransaction(
                  user: API.me,
                  transaction: _list[index],
                )),
          ),
        ),
      ),
    );
    _dialogController.forward();
  }

  void doNothing(BuildContext context) {}
}
