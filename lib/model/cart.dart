import 'package:provider/provider.dart';

class Cart {
  late int id;
  final String name;
  final String price;
  final String image;
  late int quantity;


  Cart({required this.id, required this.name, required this.price, required this.image, required this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'image': image,
    'quantity': quantity,
  };
}



