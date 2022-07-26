// ignore_for_file: unnecessary_new, prefer_collection_literals

class RegisterModel {
  String name;
  String phone;
  String gender;
  String email;
  String password;
  RegisterModel({
    required this.name,
    required this.phone,
    required this.gender,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = name;
    data["phone"] = phone;
    data["gender"] = gender;
    data["email"] = email;
    data["password"] = password;
    return data;
  }
}
