
class CustomerModel {
  String email;
  String firstName;
  String lastName;
  String username;
  String password;


  CustomerModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
  });


  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }


  Map<String, dynamic> toJson() => {
    'username': email,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
  };
}

class Shipping {
  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;

  Shipping({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
        firstName: json['first_name'],
        lastName: json['last_name'],
        address1: json['address_1'],
        address2: json['address_2'],
        city: json['city']
    );
  }

  Map<String, dynamic> toJson() => {

    'address_1': address1,
    'address_2': address2,
    'city': city
  };
}

class Billing {
  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String country;
  String phone;
  String email;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.phone,
    required this.email
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
        firstName: json['first_name'],
        lastName: json['last_name'],
        address1: json['address_1'],
        address2: json['address_2'],
        city: json['city'],
        country: json['country'],
        phone: json['phone'],
        email: json['email']
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'address_1': address1,
    'address_2': address2,
    'city': city,
    'country': country,
    'phone': phone,
    'email': email,
  };
}
