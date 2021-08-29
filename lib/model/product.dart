import 'dart:convert';
import 'image_products.dart';

class Product {
  final int id;
  final String name;
  final String price;
  final String regularPrice;
  final String salePrice;
  final List<Images> images;
  final String description;
  final String shortDescription;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.images,
    required this.description,
    required this.shortDescription,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      regularPrice: json['regularPrice'],
      salePrice: json['sale_price'] != "" ? json['sale_price'] : json['regular_price'],
      images: parsedImages(json['images']),
      description: json['description'],
      shortDescription: json['short_description']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'regular_price': regularPrice,
    'sale_price': salePrice,
    'images': images,
    'description': description,
    'short_description': shortDescription,
  };

  static List<Images> parsedImages(imageJson) {
    var list = imageJson['images'] as List;
    List<Images> imagesList = list.map((data) => Images.fromJson(data)).toList();
    return imagesList;
  }
}

