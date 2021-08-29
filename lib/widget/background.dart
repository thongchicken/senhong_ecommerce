import 'package:flutter/material.dart';
import 'package:senhongecommerce/screen/profile_edit.dart';

class Background extends StatelessWidget {

  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/top1.png",
              width: size.width,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: size.width,
            child: Image.asset(
              "assets/images/top2.png",
              width: size.width,
            ),
          ),
          // Positioned(
          //   top: 50,
          //   right: 30,
          //   child: Image.asset(
          //     "assets/images/main.png",
          //     width: size.width * 0.35,
          //   ),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/bottom1.png",
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/bottom2.png"
            )
          ),
          child
        ],
      ),
    );
  }
}
