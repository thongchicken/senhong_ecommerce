import 'customer.dart';

class CustomerDetail {
  int id;
  String firstName;
  String lastName;
  Billing billing;
  Shipping shipping;

  CustomerDetail({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.shipping,
    required this.billing,
  });


  factory CustomerDetail.fromJson(Map<String, dynamic> json) {
    return CustomerDetail(
      id: json['id'] != null ? json['id'] : 0,
      firstName: json['first_name'],
      lastName: json['last_name'],
      shipping: Shipping.fromJson(json['shipping']),
      billing: Billing.fromJson(json['billing']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'shipping': shipping.toJson(),
    'billing': billing.toJson()
  };

}
