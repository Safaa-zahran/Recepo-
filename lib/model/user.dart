// import 'package:city_crepe/model/address.dart';

class User {
  int id;
  String? name;
  String? email;
  String? phone;
  OrderCanceled lastCancel;
  // List<Address> addresses;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    // required this.addresses,
    required this.lastCancel,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      lastCancel: json['last_cancel_order'] == 0
          ? OrderCanceled.not
          : OrderCanceled.yup,
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      // addresses: List<Address>.from(
      //   json['addresses'].map((address) => Address.fromJson(address)),
      // ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_cancel_order': lastCancel,
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}

enum OrderCanceled { not, yup }
