import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {

  final String image;
  final String name;
  final double price;

  const SingleProduct({Key? key, required this.image, required this.name, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 1.0,
      child: Container(
        height: 250,
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 180,
              width: 160,
              // color: Colors.lightBlue,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                      image: AssetImage("assets/images/$image")
                  )
              ),
            ),
            Text(name, style: const TextStyle(
                fontSize: 14, color: Colors.black
            ),),
            const SizedBox(height: 10,),
            Text("$price đ", style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}
