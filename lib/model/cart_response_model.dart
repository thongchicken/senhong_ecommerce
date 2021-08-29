

class CartResponseModel {
  bool status;
  List<CartItem> data;

  CartResponseModel({required this.status, required this.data});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(status: json['status'], data: parsedCartItem(json['data']));
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()),
  };

  static List<CartItem> parsedCartItem(cartItem) {
    var list = cartItem['data'] as List;
    List<CartItem> cartList = list.map((item) => CartItem.fromJson(item)).toList();
    return cartList;
  }
}

class CartItem {
  int productId;
  String productName;
  String productRegularPrice;
  String productSalePrice;
  String thumbnail;
  int qty;
  double lineSubtotal;
  double lineTotal;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productRegularPrice,
    required this.productSalePrice,
    required this.thumbnail,
    required this.qty,
    required this.lineSubtotal,
    required this.lineTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      productName: json['product_name'],
      productRegularPrice: json['product_regular_price'],
      productSalePrice: json['product_sale_price'],
      thumbnail: json['thumbnail'],
      qty: json['qty'],
      lineSubtotal: double.parse(json['line_subtotal'].toString()),
      lineTotal: double.parse(json['line_total'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'product_name': productName,
    'product_regular_price': productRegularPrice,
    'product_sale_price': productSalePrice,
    'thumbnail': thumbnail,
    'qty': qty,
    'line_subtotal': lineSubtotal,
    'line_total': lineTotal,
  };
}