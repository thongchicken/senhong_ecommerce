
class CartRequestModel {

  int? userId;
  List<CartProduct>? products;

  CartRequestModel({required this.userId, required this.products});

  factory CartRequestModel.fromJson(Map<String, dynamic> json) {
    return CartRequestModel(
      userId: json['user_id'],
      products: parsedCartProducts(json['products'])
    );
  }
  
  static List<CartProduct> parsedCartProducts(cartProduct) {
    var list = cartProduct['products'] as List;
    List<CartProduct> listCartProducts = list.map((product) => CartProduct.fromJson(product)).toList();
    return listCartProducts;
  }

}

class CartProduct {
  int? productId;
  int? quantity;

  CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(productId: json['productId'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
  };
}