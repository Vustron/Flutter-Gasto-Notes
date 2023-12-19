// ignore_for_file: no_leading_underscores_for_local_identifiers
class Transactions {
  Transactions({
    required this.userId,
    required this.title,
    required this.amount,
    required this.transactionDate,
    required this.category,
  });
  late final String userId;
  late final String title;
  late final int amount;
  late final String transactionDate;
  late final String category;

  Transactions.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    title = json['title'].toString();
    amount = int.tryParse(json['amount'].toString())!;
    transactionDate = json['transactionDate'].toString();
    category = json['category'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['title'] = title;
    data['amount'] = amount;
    data['transactionDate'] = transactionDate;
    data['category'] = category;
    return data;
  }
}