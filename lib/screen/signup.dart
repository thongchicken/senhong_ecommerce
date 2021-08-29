import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhongecommerce/model/customer.dart';
import 'package:senhongecommerce/navigator_controller.dart';
import 'package:senhongecommerce/screen/login_screen.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:senhongecommerce/widget/my_button.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class _SignUpState extends State<SignUp> {

  late bool obserText = true;
  late String password;

  late String passwordSignup;
  late String emailSignup;
  late String firstName;
  late String lastName;

  ApiService apiService = new ApiService();
  CustomerModel customerModel = CustomerModel(email: '', firstName: '', lastName: '', username: '', password: '');


  @override
  void initState() {
    apiService;
    customerModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Widget>[
                            Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 600,
                        width: double.infinity,
                        // color: Colors.lightBlue,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "First name",
                              ),
                              validator: (value) {
                                if (value == "") {
                                  return "First name is required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                this.customerModel.firstName = value!.trim();
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Last name",
                              ),
                              validator: (value) {
                                if (value == "") {
                                  return "Last name is required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                this.customerModel.lastName = value!.trim();
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                              ),
                              validator: (value) {
                                if (value == "") {
                                  return "Email is required";
                                } else if (!emailValid(value.toString())) {
                                  return "Email is invalid";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                this.customerModel.email = value!.trim();
                              },
                            ),
                            TextFormField(
                              obscureText: obserText,
                              onChanged: (value) {
                                setState(() {
                                  passwordSignup = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obserText = !obserText;
                                      });
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Icon(obserText == true ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                                  )
                              ),
                              validator: (value) {
                                if (value == "") {
                                  return "Password is required";
                                } else if (value.toString().length < 8) {
                                  return "Password must is minimum 8 letters";
                                } else {
                                  password = value.toString();
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                this.customerModel.password = value!;
                              },
                            ),
                            TextFormField(
                              obscureText: obserText,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Confirm password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obserText = !obserText;
                                      });
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Icon(obserText == true ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                                  )
                              ),
                              validator: (value) {
                                if (value == ""){
                                  return "Confirm password is required";
                                } else if (value.toString() != password){
                                  return "Confirm password is invalid";
                                } else return null;
                              },
                            ),
                            MyButton(onPressed: (){
                              if (validation()) {
                                // print("dang ky thanh cong ${customerModel.toJson()}");
                                var firstName = this.customerModel.firstName;
                                var lastName = this.customerModel.lastName;
                                var email = this.customerModel.email;
                                var password = this.customerModel.password;
                                print(customerModel.toJson());
                                // apiService.createCustomer(firstName, lastName, firstName+lastName, email, password).then((value){
                                //   if (value != null) {
                                //     print(value.toJson());
                                //     Navigator.of(context).pushReplacement(
                                //       MaterialPageRoute(builder: (navigate) => NavigatorController())
                                //     );
                                //   } else {
                                //     print("loi trong navigate ${value}");
                                //   }
                                // });
                              } else {
                                print("dang ky khong thanh cong");
                              }
                            }, name: "Register"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text("I have account already "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (ctx) => LoginScreen()
                                        )
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.cyan, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  bool emailValid (String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool validation()  {
    final FormState? _form = _formKey.currentState;
    if(_form!.validate()) {
      _form.save();
      return true;
    } else {
      return false;
    }
  }
}
