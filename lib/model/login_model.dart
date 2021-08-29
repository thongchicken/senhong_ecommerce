import 'customer.dart';

class LoginResponseModel {
  bool success;
  int statusCode;
  String code;
  String message;
  Data data;
  // Shipping shipping;

  LoginResponseModel({
    required this.success,
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
    // required this.shipping,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      statusCode: json['statusCode'],
      code: json['code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
      // shipping: Shipping.fromJson(json['shipping']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'code': code,
    'message': message,
    'data': data,
    // 'shipping': shipping,
  };
}

class Data {
  String token;
  int id;
  String email;
  String nicename;
  String firstName;
  String lastName;
  String displayName;

  Data({
    required this.token,
    required this.id,
    required this.email,
    required this.nicename,
    required this.lastName,
    required this.firstName,
    required this.displayName,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      id: json['id'],
      email: json['email'],
      nicename: json['nicename'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'id': id,
    'email': email,
    'nicename': nicename,
    'firstName': firstName,
    'lastName': lastName,
    'displayName': displayName,
  };
}

class LoginRequestModel {
  late final String email;
  late String password;

  LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}