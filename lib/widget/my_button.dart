import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function onPressed;
  final String name;
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.name,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
        color: Colors.blue,
      ),
    );
  }

}
