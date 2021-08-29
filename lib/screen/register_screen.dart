import 'package:flutter/material.dart';
import 'package:senhongecommerce/model/customer.dart';
import 'package:senhongecommerce/screen/login_screen.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:senhongecommerce/widget//background.dart';
import 'package:senhongecommerce/navigator_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  ApiService apiService = ApiService();

  bool  obsertText = true;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    passwordController.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    apiService;
    super.initState();
  }

  bool emailValid (String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text(
                    "ĐĂNG KÝ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "First name",
                    ),
                    validator: (firstName) {
                      if (firstName.toString().isEmpty) {
                        return "Họ không thể để trống";
                      } else {
                        return null;
                      }
                    },
                    controller: firstName,
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Last name",
                    ),
                    validator: (lastName) {
                      if (lastName.toString().isEmpty) {
                        return "Tên không được để trống";
                      } else {
                        return null;
                      }
                    },
                    controller: lastName,
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email"
                    ),
                    validator: (email) {
                      if (email.toString().isEmpty) {
                        return "Email không được trống";
                      } else if (!emailValid(email.toString())) {
                        return "Email không hợp lệ";
                      } else {
                        return null;
                      }
                    },
                    controller: email,
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Mật khẩu",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          obsertText = !obsertText;
                        },
                        child: Icon(obsertText ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                      )
                    ),
                    obscureText: obsertText,
                    validator: (password) {
                      if (password.toString().isEmpty) {
                        return "Mật khẩu không thể để trống";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    obscureText: obsertText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nhập lại mật khẩu",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          obsertText = !obsertText;
                        },
                        child: Icon(obsertText ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                      )
                    ),
                    validator: (repass) {
                      if (repass.toString().isEmpty) {
                        return "Nhập lại mật khẩu không thể để trống";
                      } else if (repass != passwordController.text) {
                        return "Mật khẩu không khớp";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CustomerModel model = CustomerModel(email: email.text, firstName: firstName.text, lastName: lastName.text, username: email.text, password: passwordController.text);
                        print(model.toJson());
                        apiService.createCustomer(model).then((ret) => {
                          if (ret) {
                            showDialog(
                              context: context,
                              builder: (_) => alertDialog(),
                            )
                          } else {
                            print("khong the dang ky")
                          }
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        "ĐĂNG KÝ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (navigate) => NavigatorController())
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: const Text(
                        "QUAY LẠI TRANG CHỦ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget alertDialog() {
    return AlertDialog(
      title: Text("Message"),
      content: Text("Đăng ký thành công"),
      actions: [
        FlatButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => LoginScreen())
          );
        }, child: Text("Yes")),
        FlatButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: Text("No"))
      ],
    );
  }
}
