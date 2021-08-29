import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senhongecommerce/config.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  final _controller = TextEditingController();
  final _email = TextEditingController();
  final _lastName = TextEditingController();
  final _firstName = TextEditingController();
  final _password = TextEditingController();

  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
      )
    );
  }

  Column buildColumn() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _firstName,
          decoration: const InputDecoration(hintText: 'Enter first name'),
        ),
        TextField(
          controller: _lastName,
          decoration: const InputDecoration(hintText: 'Enter last name'),
        ),
        TextField(
          controller: _email,
          decoration: const InputDecoration(hintText: 'Enter email'),
        ),
        TextField(
          controller: _password,
          decoration: const InputDecoration(hintText: 'Enter password'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              User user = User(firstName: _firstName.text, lastName: _lastName.text, email: _email.text, password: _password.text);
              print(user.toJson());
              _futureUser = createUser(user);
            });
          },
          child: const Text('Create data')
        ),
      ],
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Error"),);
        } else if (snapshot.hasData){
          return Text(snapshot.data!.email);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}


class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'username': firstName + " " + lastName,
    'password': password
  };
}

Future<User> createUser(User user) async {

  var authKey = Config.key + Config.secret;

  final response = await http.post(
    Uri.parse(Config.url + Config.customers),
    headers: <String, String> {
      // HttpHeaders.authorizationHeader: 'Basic $authKey',
      HttpHeaders.acceptHeader: 'application/json'
    },
    body: user.toJson()
  );

  print("trang thai dang ky ${response.statusCode}");
  print("response ${jsonDecode(response.body)}");
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user');
  }
}

















class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title
  };
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse("https://jsonplaceholder.typicode.com/albums"),
    headers: <String, String>{
      ''
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title
    }),
  );

  print("trang thai dang ky ${response.statusCode}");
  print("response ${response.body}");

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to created album');
  }
}























Future<List<Album>> fetchAlbums() async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/"));
  return parseAlbum(response.body);
}

List<Album> parseAlbum(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}


class ListAlbums extends StatelessWidget {
  const ListAlbums({Key? key, required this.listCate}) : super(key: key);

  final List<Cat> listCate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listCate.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(listCate[index].image.src),
        );
      },
    );
  }
}

class Cat {
  final int id;
  final String name;
  final Image image;

  Cat({required this.id, required this.name, required this.image});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      name: json['name'],
      image: Image.fromJson(json['image'])
    );
  }
}

class Image {
  final int id;
  final String src;

  Image({required this.id, required this.src});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(id: json['id'], src: json['src']);
  }
}

Future<List<Cat>> fetchCat() async {
  final response = await http.get(Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/products/categories?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c"));
  print(jsonDecode(response.body));
  return parseCat(response.body);
}

List<Cat> parseCat(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Cat>((json) => Cat.fromJson(json)).toList();
}

