

import 'dart:convert';

import 'package:senhongecommerce/model/cart.dart';
import 'package:senhongecommerce/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {


  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") != null ? true : false;
  }

  static Future<LoginResponseModel?> loginDetail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null
        ? LoginResponseModel.fromJson(json.decode(prefs.getString("login_details")!))
        : null;
  }

  static Future setLoginDetails(LoginResponseModel loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(
      "login_details",
      json.encode(loginResponse.toJson())
    );
  }

  Future<void> setInValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("key_int", 1234);
  }

  Future saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', 'Nguyen Nhut Thong');

    print('saved name');
  }

  Future<LoginResponseModel?> saveUser(LoginResponseModel loginResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("id", json.encode(loginResponseModel.data.id));
    prefs.setString("first_name", json.encode(loginResponseModel.data.firstName));
    prefs.setString("last_name", json.encode(loginResponseModel.data.lastName));
    prefs.setString("display_name", json.encode(loginResponseModel.data.displayName));
    prefs.setString("email", json.encode(loginResponseModel.data.email));
    // prefs.setString("address", json.encode(loginResponseModel.shipping.address1));
    // prefs.setString("city", json.encode(loginResponseModel.shipping.city));
  }

  Future removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("id");
    await prefs.remove("first_name");
    await prefs.remove("last_name");
    await prefs.remove("display_name");
    await prefs.remove("email");
    // await prefs.remove("address");
    // await prefs.remove("city");
    print("da xoa user");
  }

  Future isLogged(bool flag) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogged", flag);
  }



}