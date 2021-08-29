import 'package:flutter/material.dart';
import 'package:senhongecommerce/widget/background.dart';
import 'package:senhongecommerce/navigator_controller.dart';
import 'package:senhongecommerce/screen/register_screen.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:senhongecommerce/shared_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  bool obserText = true;

  final emailAndUsernameController = TextEditingController();
  final passwordController = TextEditingController();
  ApiService apiService = ApiService();
  SharedService sharedService = SharedService();

  @override
  void initState() {
    apiService;
    super.initState();
  }

  @override
  void dispose() {
    emailAndUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool emailValid (String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Username",
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Username không thể trống";
                      } else {
                        return null;
                      }
                    },
                    controller: emailAndUsernameController,
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obserText = !obserText;
                          });
                        },
                        child: Icon(obserText ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                      )
                    ),
                    obscureText: obserText,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Mật khẩu không thể để trống";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Forgot your passwrod",
                    style: TextStyle(fontSize: 12, color: Color(0xFF2661FA)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        var username = emailAndUsernameController.text.trim();
                        var password = passwordController.text;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Processing data...", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),))
                        );
                        apiService.loginCustomer(username, password).then((loginResponse){
                          if (loginResponse != null) {
                            sharedService.saveUser(loginResponse);

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (navigate) => NavigatorController())
                            );
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
                      // width: size.width * 0.5,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(30),
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       Color.fromARGB(255, 255, 136, 34),
                      //       Color.fromARGB(255, 255, 177, 41)
                      //     ]
                      //   )
                      // ),
                      child: Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (navigate) => RegisterScreen())
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        "SIGNUP",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
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
}
