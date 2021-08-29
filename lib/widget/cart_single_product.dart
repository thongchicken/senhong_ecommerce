import 'package:flutter/material.dart';

class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final int quantity;

  const CartSingleProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity
  });

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

late int count;

class _CartSingleProductState extends State<CartSingleProduct> {

  int item = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.all(2.0),
      width: double.infinity,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("${widget.image}"),
                      )
                  ),
                ),
                Expanded(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text((widget.name.toString())),
                          Text("${widget.price.toString()} đ"),
                          Container(
                            height: 30,
                            width: 100,
                            padding: const EdgeInsets.all(4),
                            color: Colors.grey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.remove, color: Colors.white,),
                                  onTap: () {
                                    if (widget.quantity > 1) {
                                      setState(() {
                                        item--;
                                      });
                                    }
                                  },
                                ),
                                Text(item.toString(), style: TextStyle(fontSize: 20, color: Colors.white),),
                                GestureDetector(
                                  onTap: () {
                                    if (item < 10) {
                                      setState(() {
                                        item++;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.add, color: Colors.white,),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
