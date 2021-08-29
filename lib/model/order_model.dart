import 'customer.dart';

class OrderModel {
  int customerId;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  List<LineItems> lineItems;
  String total;
  int orderId;
  String orderNumber;
  String status;
  String orderDate;
  // Billing billing;
  // Shipping shipping;

  OrderModel({
    required this.customerId,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.lineItems,
    required this.total,
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.orderDate,
    // required this.billing,
    // required this.shipping,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      customerId: json['customer_id'],
      paymentMethod: json['payment_method'],
      paymentMethodTitle: json['payment_method_title'],
      transactionId: json['transaction_id'],
      total: json['total'],
      lineItems: parsedItems(json['line_items']),
      orderId: json['id'] ,
      status: json['status'],
      orderNumber: json['order_key'],
      orderDate: json['date_created'],
      // billing: Billing.fromJson(json['billing'])
      // shipping: json['shipping'],
    );
  }

  Map<String, dynamic> toJson() => {
    'customer_id': customerId,
    'payment_method': paymentMethod,
    'payment_method_title': paymentMethodTitle,
    'transaction_id': transactionId,
    // 'billing': billing.toString(),
    // 'shipping': shipping.toJson(),
    'line_items': lineItems
  };

  static List<LineItems> parsedItems(itemsJson) {
    var list = itemsJson['line_items'] as List;
    List<LineItems> itemsList = list.map((data) => LineItems.fromJson(data)).toList();
    return itemsList;
  }
}

class LineItems {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String subTotal;
  String total;
  int price;

  LineItems({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.subTotal,
    required this.total,
    required this.price,
  });

  factory LineItems.fromJson(Map<String, dynamic> json) {
    return LineItems(
      id: json['id'],
      name: json['name'],
      productId: json['product_id'],
      variationId: json['variation_id'],
      quantity: json['quantity'],
      subTotal: json['subtotal'],
      total: json['total'],
      price: json['price']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'product_id': productId,
    'variation_id': variationId,
    'quantity': quantity,
    'subtotal': subTotal,
    'total': total,
    'price': price,
  };

  // static List<LineItems> parsedLineItems(lineItemsJson) {
  //   var list = lineItemsJson['line_items'] as List;
  //   List<LineItems> lineItems = list.map((data) => LineItems.fromJson(data)).toList();
  //   return lineItems;
  // }
}