// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/transaction.dart';
import '../model/user.dart';

class API {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;
  // for storing self information
  static late UserData me;
  // to return current user
  static User get user => auth.currentUser!;

  // check if the user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for getting user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = UserData.fromJson(user.data()!);
        print('My Data: ${user.data()}');
      } else {
        createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      UserData user) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: user.id)
        .snapshots();
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final appUser = UserData(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey I'm using Gasto-Notes!",
        image: user.photoURL.toString(),
        createdAt: time,
        income: 0.00,
        expenses: 0.00,
        balance: 0.00);

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(appUser.toJson());
  }

  // Get all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    print('\nUserIds: $userIds');

    return firestore
        .collection('users')
        .where('id', whereIn: userIds.isEmpty ? [''] : userIds)
        .snapshots();
  }

  // for updating user information
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // for updating user profile picture
  static Future<void> updateUserProfilePicture(File file) async {
    // Getting image file extension
    final ext = file.path.split('.').last;
    print('Extension: $ext');

    // storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    // uploading image
    await ref
        .putFile(
            file,
            SettableMetadata(
              contentType: 'image/$ext',
            ))
        .then((p0) {
      print('Data transferred: ${p0.bytesTransferred / 1000} kb');
    });

    // Updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore.collection('users').doc(user.uid).update({
      'image': me.image,
    });
  }

  ///****************Transaction Screen related API**********************
  //get conversation id
  static String getTransactionsID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // Get all transactions
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllTransactions(
      UserData appUser) {
    return firestore
        .collection(
            'transaction_list/${getTransactionsID(appUser.id)}/transactions/')
        .orderBy('type', descending: true)
        .snapshots();
  }

  // for adding transactions
  static Future<void> addingTransaction(
    UserData appUser,
    String title,
    double amount,
    String transactionDate,
    String category,
    String type,
  ) async {
    // transaction sending time(also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // transaction to send
    final Transactions transaction = Transactions(
      userId: appUser.id,
      title: title,
      amount: amount,
      transactionDate: transactionDate,
      category: category,
      type: type,
      sent: time,
    );

    final ref = firestore.collection(
        'transaction_list/${getTransactionsID(appUser.id)}/transactions/');
    await ref.doc(time).set(transaction.toJson());

    if (transaction.type == 'Expense' || transaction.type == 'Income') {
      double newAmount = transaction.type == 'Expense'
          ? appUser.expenses + amount
          : appUser.income + amount;

      double newBalance = transaction.type == 'Expense'
          ? appUser.balance - amount
          : appUser.balance + amount;

      await firestore.collection('users').doc(appUser.id).update({
        'expenses':
            transaction.type == 'Expense' ? newAmount : appUser.expenses,
        'income': transaction.type == 'Income' ? newAmount : appUser.income,
        'balance': newBalance,
      });
    }
  }

  // for updating transactions
  static Future<void> updateTransaction(
    UserData appUser,
    Transactions transaction,
    String title,
    double amount,
    String transactionDate,
    String category,
    String type,
  ) async {
    final transactionCollection = firestore.collection(
      'transaction_list/${getTransactionsID(appUser.id)}/transactions/',
    );

    // Retrieve the old amount and type
    double oldAmount = transaction.amount;
    String oldType = transaction.type;

    // Update the transaction details
    await transactionCollection.doc(transaction.sent).update({
      'title': title,
      'amount': amount,
      'transactionDate': transactionDate,
      'category': category,
      'type': type,
    });

    // Update user's balance based on the old and new types
    double oldBalance = appUser.balance;
    double newBalance = oldBalance;

    if (oldType == 'Expense' || oldType == 'Income') {
      newBalance = oldType == 'Expense'
          ? oldBalance + oldAmount
          : oldBalance - oldAmount;
    }

    if (type == 'Expense' || type == 'Income') {
      newBalance =
          type == 'Expense' ? newBalance - amount : newBalance + amount;
    }

    // Update user data
    await firestore.collection('users').doc(appUser.id).update({
      'expenses': type == 'Expense'
          ? appUser.expenses + amount
          : appUser.expenses - oldAmount,
      'income': type == 'Income'
          ? appUser.income + amount
          : appUser.income - oldAmount,
      'balance': newBalance,
    });
  }

  // for deleting transactions
  static Future<void> deleteTransaction(
    UserData appUser,
    Transactions transaction,
    double amount,
    String type,
  ) async {
    final transactionCollection = firestore.collection(
      'transaction_list/${getTransactionsID(appUser.id)}/transactions/',
    );

    await transactionCollection.doc(transaction.sent).delete();

    if (type == 'Expense' || type == 'Income') {
      double oldAmount = amount;

      double newExpenses =
          type == 'Expense' ? appUser.expenses - oldAmount : appUser.expenses;
      double newIncome =
          type == 'Income' ? appUser.income - oldAmount : appUser.income;

      double newBalance = type == 'Expense'
          ? appUser.balance + oldAmount
          : appUser.balance - oldAmount;

      await firestore.collection('users').doc(appUser.id).update({
        'expenses': newExpenses,
        'income': newIncome,
        'balance': newBalance,
      });
    }
  }
}
