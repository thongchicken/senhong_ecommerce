import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhongecommerce/model/customer_detail.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:senhongecommerce/widget/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  final textController = TextEditingController();
  ApiService apiService = ApiService();

  @override
  void initState() {
    apiService;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa hồ sơ"),
        centerTitle: true,
      ),
      body: _buildMainProfileEdit()
    );
  }

  Widget _buildMainProfileEdit() {
    return Form(
      key: _formkey,
      child: Container(
        margin: EdgeInsets.all(2),
        child: ListView(
          children: <Widget>[
            _buildTitle("Tên"),
            _buildFirstName(),
            const SizedBox(height: 5,),
            _buildTitle("Số điện thoại"),
            _buildPhoneNumber(),
            const SizedBox(height: 10,),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsername() {
    return Row(
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Ho",
              border: OutlineInputBorder()
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Ten",
              border: OutlineInputBorder()
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 16),);
  }

  Widget _buildFirstName() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: MyButton(
        onPressed: () async {
          // loadUserInfor();
          var json = {
            "first_name": "Nhut Thong",
            "last_name": "Nguyen",
            "email": "nguyennhutthong.it@gmail.com",
            "shipping": {
              "address_1": "KTX khu Dai hoc Can Tho",
              "address_2": "",
              "city": "Can Tho",
              "phone": "0917488548",
            }
          };

          // User user = User.fromJson(json);
          // loadUserInfor();
          apiService.customerDetail().then((value){
            // print(value!.shipping.toJson());
            print("${value!.shipping.toJson()}  ${value.billing.toJson()}");
          });

        },
        name: "Update"
      )
    );
  }
  
  Future loadUserInfor() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    print("customer id $id");
    var response = await http.get(
      Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/customers/$id?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c"),
      headers: {
        HttpHeaders.acceptHeader: "application/json"
      }
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonUser = jsonDecode(responseBody);
      print(jsonUser['last_name']);
      print(jsonUser['first_name']);
      print(jsonUser['shipping']['address_1']);
      print(jsonUser['shipping']['city']);
    } else {
      print("Not response");
    }
  }

}


class User {
  String firstName;
  String lastName;
  String email;
  Shipping shipping;
  
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.shipping,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      shipping: Shipping.fromJson(json['shipping'])
    );
  }
  
  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'shipping': shipping,
  };
}


class Shipping {
  String address1;
  String address2;
  String city;
  String phone;

  Shipping({
    required this.address1,
    required this.address2,
    required this.city,
    required this.phone
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      address1: json['address_1'],
      address2: json['address_2'] != "" ? json['address_2'] : "chưa có địa chỉ",
      city: json['city'],
      phone: json['phone']
    );
  }

  Map<String, dynamic> toJson() => {
    'address_1': address1,
    'address_2': address2,
    'city': city,
    'phone': phone,
  };
}
