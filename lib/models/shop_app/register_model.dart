class ShopRegisterModel {
  late bool status;
  late String? message;
  Data? data;

  ShopRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }
}

class Data {
  String? name;
  String? email;
  String? phone;
  String? token;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}
