import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {

  final String labelTextField;
  final bool suffix;

  const MyTextFormField({
    Key? key,
    required this.labelTextField,
    required this.suffix,
  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool obserText = true;
  late String password;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.suffix,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelTextField,
        suffixIcon: widget.suffix == false ? null : GestureDetector(
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
        List<String> key = widget.labelTextField.toString().toLowerCase().split(" ");
        // print('key ${key[0]} ');
        // check validate for full name
        if (widget.labelTextField.toString().toLowerCase().contains("full name")) {
          if (value == "") {
            return "Full name is required";
          }
          return null;
        } // end if for full name check validate
        // check validate for email
        else if (widget.labelTextField.toString().toLowerCase().contains("email")){
          if (value == "") {
            return "Email is required";
          } else if (!emailValid(value.toString())) {
            return "Email is invalid";
          }
          return null;
        } // end if for email check validate
        // check validate for password
        else if (widget.labelTextField.toLowerCase().toString().contains("password")) {
          if (value == ""){
            return "Password is required";
          } else if (value.toString().length < 8) {
            return "Password must minimum 8 letters";
          }
          password = value.toString();
          print(password);
          return null;
        } // end if for password check validate
        // check confirm password
        else if (widget.labelTextField.toLowerCase().toString().compareTo("confirm password")==1){
          if (value == ""){
            return "Confirm password is required";
          } else if (value.toString().length < 8) {
            print('confirm password: ${password}');
            // print(value);
            return "Confirm password is invalid";
          }
          return null;
        }
        else return null;
      },
    );
  }

  bool emailValid (String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
