import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:senhongecommerce/config.dart';
import 'package:senhongecommerce/model/cart_request_model.dart';
import 'package:senhongecommerce/model/cart_response_model.dart';
import 'package:senhongecommerce/model/categories.dart';
import 'package:senhongecommerce/model/customer.dart';
import 'package:senhongecommerce/model/customer_detail.dart';
import 'package:senhongecommerce/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  
  static String url = "https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/customers?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c";
  var authKey = base64.encode(utf8.encode(Config.key + ":" + Config.secret));

  Future<bool> createCustomer(CustomerModel model) async {

    bool ret = false;

    try {
      var response = await http.post(
        Uri.parse(Config.url+Config.customers),
        body: model.toJson(),
        headers: {
          HttpHeaders.authorizationHeader: "Basic $authKey",
          HttpHeaders.acceptHeader: "application/json",
          // HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        },
      );

      print("trang thai dang ky ${response.statusCode} buon qua ${response}");
      if (response.statusCode == 201) {
        ret = true;
        // print("trang thai dang ky ${response.statusCode}");
        // customerModel = CustomerModel.fromJson(json.decode(response.body));
      }
    } on Exception catch (e) {
      print(e);
    }

    return ret;
  }
  
  Future<CustomerDetail?> customerDetail() async {
    CustomerDetail customerDetail;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString("id");
    
    var response = await http.get(Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/customers/$customerId?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c"));
    if (response.statusCode == 200) {

    }
  }

  Future<LoginResponseModel?> loginCustomer(String username, String password) async {
    LoginResponseModel? model;

    try {
      var response = await http.post(
        Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/jwt-auth/v1/token"),
        body: {
          "username": username,
          "password": password,
        },
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }
      );

      print("trang thai dang nhap ${response.statusCode}");
      if (response.statusCode == 200) {
        print("trang thai dang nhap o trong if ${response.statusCode}");
        model = LoginResponseModel.fromJson(json.decode(response.body));
        print(model.toJson());
      }
    } on Exception catch(e) {
      print("loi khong dang nhap duoc ${e}");
    }
    return model;
  }

  Future<CartResponseModel?> addToCart(CartRequestModel model) async {
    model.userId = 2;

    CartResponseModel? responseModel;

    try {
      var response = await http.post(
        Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/addtocart"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(json.decode(response.body));
      }
    } on Exception catch(e) {
      print("Loi o day nay ${e}");
    }

    return responseModel;
  }

  Future<CartResponseModel?> getCartItems() async {
    CartResponseModel? responseModel;

    try {
      var response = await http.get(
        Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/addtocart?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c"),
        headers: {
          HttpHeaders.contentTypeHeader: "appliation/json",
        }
      );

      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(json.decode(response.body));

      }
    } on Exception catch(e) {
      print("loi get item cart ${e}");
    }

    return responseModel;
  }


  Future<List<SenHongCategory>> fetchCategories() async {
    String uri = Config.url + Config.categories + Config.key + Config.secret;
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      }
    );
    return parseCat(response.body);
  }

  List<SenHongCategory> parseCat(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SenHongCategory>((json) => SenHongCategory.fromJson(json)).toList();
  }

  // Future<CustomerDetail?> customerDetail() async {
  //
  //   CustomerDetail? responseModel;
  //   final prefs = await SharedPreferences.getInstance();
  //   String? customerId = prefs.getString("id");
  //
  //   try {
  //     var response = await http.get(
  //       Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/customers/$customerId?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c"),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json"
  //       }
  //     );
  //
  //     print("trang thai customer ${response.statusCode}");
  //
  //     if (response.statusCode == 200) {
  //       responseModel = CustomerDetail.fromJson(jsonDecode(response.body));
  //     }
  //   } on HttpException catch (e) {
  //     print("loi customer model detail $e");
  //   }
  //
  //   return responseModel;
  // }


}