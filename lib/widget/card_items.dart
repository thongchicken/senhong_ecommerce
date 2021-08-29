import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senhongecommerce/provider/product_provider.dart';

class CardItems extends StatefulWidget {

  final int id;
  final int index;
  final String name;
  final String image;
  final String price;
  int quantity;

  CardItems({required this.id, required this.index, required this.name, required this.image, required this.price, required this.quantity});
  @override
  _CardItemsState createState() => _CardItemsState();
}

late ProductProvider productProvider;

class _CardItemsState extends State<CardItems> {

  final formatCurrency = NumberFormat("#,##0");
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 200,
      margin: EdgeInsets.all(2.0),
      width: double.infinity,
      child: Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                width: double.infinity,
                color: Color(0xffbdc3c7),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }
                    ),
                    Text("Nhứt Thống Store", style: TextStyle(fontSize: 18, color: Colors.white),)
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage("${widget.image}"),
                          )
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 77,
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(reduceString(widget.name)),
                            ),
                            Container(
                              height: 25,
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text("Giá: ${formatCurrency.format(double.parse(widget.price)).toString()} VNĐ"),
                            ),
                            Container(
                              height: 28,
                              width: 100,
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.symmetric(vertical: 2),
                              color: Colors.grey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Icon(Icons.remove, color: Colors.white,),
                                    onTap: () {
                                      if (widget.quantity > 1) {
                                        int index = 0;
                                        setState(() {
                                          widget.quantity--;
                                          for(int i=0; i<productProvider.getCartLength; i++) {
                                            if (productProvider.getCartModelList[i].id == widget.id) {
                                              index = i;
                                            }
                                          }
                                          productProvider.getCartModelList[index].quantity = widget.quantity;
                                        });
                                        print(widget.quantity);
                                      }
                                    },
                                  ),
                                  Text(
                                      widget.quantity.toString(),
                                      style: TextStyle(fontSize: 20, color: Colors.white)
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.add, color: Colors.white,),
                                    onTap: () {
                                      if (widget.quantity < 10) {
                                        int index = 0;
                                        setState(() {
                                          widget.quantity++;
                                          for(int i=0; i<productProvider.getCartLength; i++) {
                                            if (productProvider.getCartModelList[i].id == widget.id) {
                                              index = i;
                                            }
                                          }
                                          productProvider.getCartModelList[index].quantity = widget.quantity;
                                        });

                                      }
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      productProvider.deleteItemsCart(widget.index);
                    }, icon: Icon(Icons.close)),
                  ]
              ),
            ]
        ),
      ),
    );
  }


  String reduceString(String name) {
    if (name.toString().length > 80) {
      name = name.substring(0, 64);
      name = name + "...";
    }
    return name;
  }
}
