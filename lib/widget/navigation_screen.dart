import 'package:flutter/material.dart';

class NavigatorScreen extends StatelessWidget {

  final String name;
  final String whichAccount;
  final Function onTap;

  const NavigatorScreen({Key? key, required this.name, required this.onTap, required this.whichAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(whichAccount),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue
            )
          ),

        ),
      ],
    );
  }
}
