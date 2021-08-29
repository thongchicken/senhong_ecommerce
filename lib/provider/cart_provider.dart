

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:senhongecommerce/model/cart_request_model.dart';
import 'package:senhongecommerce/model/cart_response_model.dart';
import 'package:senhongecommerce/model/customer_detail.dart';
import 'package:senhongecommerce/senhong_api_service.dart';

class CartProvider with ChangeNotifier {
  late ApiService _apiService;
  late List<CartItem> _cartItems;

  List<CartItem> get CartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();

  CartProvider() {
    _apiService = ApiService();
    _cartItems = <CartItem>[];
  }

  void resetStream() {
    _apiService = ApiService();
    _cartItems = <CartItem>[];
  }
  
  void addToCart(CartProduct product, Function onCallback) async {
    CartRequestModel requestModel =  CartRequestModel(userId: 0, products: []);

    if (_cartItems == null) resetStream();

    _cartItems.forEach((element) {
      requestModel.products!.add(
        CartProduct(productId: element.productId, quantity: element.qty)
      );
    });

    var isProductExist = requestModel.products!.firstWhere(
      (prd) => prd.productId == product.productId,
      orElse: null
    );

    if (isProductExist != null) {
      requestModel.products!.remove(isProductExist);
    }
    requestModel.products!.add(product);
    await _apiService.addToCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel!.data != null) {
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }

}