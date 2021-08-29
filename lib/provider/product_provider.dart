import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:senhongecommerce/model/cart.dart';
import 'package:senhongecommerce/model/customer_detail.dart';
import 'package:senhongecommerce/model/product.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {

  final String key = "consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745";
  final String secret = "consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c";
  final String url = "http://senhongecommerce.000webhostapp.com/wp-json/wc/v3/";
  final String type = "products";
  final String uri = "http://senhongecommerce.000webhostapp.com/wp-json/wc/v3/products?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c";

  List<Product> listAllProducts = [];

  // ** product provider listener
  List<Cart> cartList = [];
  late Cart cart;
  late CustomerDetail _customerDetail;
  late ApiService apiService;

  void addToCart({required int id, required String name, required String image, required String price, required int quantity}) {
    int index = 0;
    bool flag = true;
    cart = Cart(id: id, name: name, price: price, image: image, quantity: quantity);
    for (int i=0; i<cartList.length; i++) {
      if (cartList[i].id == cart.id) {
        print("id cua cart list ${cartList[i].id}  id cua cart ${cart.id} index la ${i}");
        if (cart.quantity > 1) {
          cartList[i].quantity += quantity;
        } else {
          cartList[i].quantity += 1;
        }
        flag = false;
      }
    }

    if (flag) {
      cartList.add(cart);
    }

    notifyListeners();
  }

  Future updateCartSharedPreference() async {
    List<String> myCart = cartList.map((e) => json.encode(e.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("my_cart", myCart);
  }

  List<Cart> get getCartModelList {
    return List.from(cartList);
  }

  int get getCartLength {
    return cartList.length;
  }

  void deleteItemsCart(int index) {
    cartList.removeAt(index);
    notifyListeners();
  }


  // ** notification listener
  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length; 
  }


  List<Product> get getAllProduct {
    return listAllProducts;
  }

  CustomerDetail get customerDetail => _customerDetail;

  fetchShippingDetail() async {
    _customerDetail = (await apiService.customerDetail())!;
    notifyListeners();
  }
}