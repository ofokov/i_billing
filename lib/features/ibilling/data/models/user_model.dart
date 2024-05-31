import 'package:i_billing/features/ibilling/domain/enteties/user.dart';

class UserModel extends User {
  UserModel(
      {required super.fullName,
      required super.profession,
      required super.dateOfBirth,
      required super.email,
      required super.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String,
      profession: json['profession'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'profession': profession,
      'dateOfBirth': dateOfBirth,
      'email': email,
    };
  }
}
