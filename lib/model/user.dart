// ignore_for_file: no_leading_underscores_for_local_identifiers

class UserData {
  UserData({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
  });
  late String image;
  late String about;
  late String name;
  late String createdAt;
  late String id;
  late String email;

  UserData.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? [];
    about = json['about'] ?? [];
    name = json['name'] ?? [];
    createdAt = json['created_at'] ?? [];
    id = json['id'] ?? [];
    email = json['email'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}
