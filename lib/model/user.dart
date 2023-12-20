// ignore_for_file: no_leading_underscores_for_local_identifiers

class UserData {
  UserData({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
    required this.income,
    required this.expenses,
    required this.balance,
  });
  late String image;
  late String about;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late double income;
  late double expenses;
  late double balance;

  UserData.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? [];
    about = json['about'] ?? [];
    name = json['name'] ?? [];
    createdAt = json['created_at'] ?? [];
    id = json['id'] ?? [];
    email = json['email'] ?? [];
    income = double.tryParse(json['income'].toString())!;
    expenses = double.tryParse(json['expenses'].toString())!;
    balance = double.tryParse(json['balance'].toString())!;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['income'] = income;
    data['expenses'] = expenses;
    data['balance'] = balance;
    return data;
  }

  copyWith() {}
}
