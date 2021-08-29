import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senhongecommerce/provider/product_provider.dart';
import 'package:senhongecommerce/screen/checkout.dart';
import 'package:senhongecommerce/screen/detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:senhongecommerce/widget/card_items.dart';

class CartScreen extends StatefulWidget {

  @override
  State<CartScreen> createState() => _CartScreenState();
}

late ProductProvider productProvider;

class _CartScreenState extends State<CartScreen> {

  int item = 1;
  final formatCurrency = NumberFormat("#,##0");

  void initState() {
    productProvider = ProductProvider();
    print("be trong cart list: ${productProvider.getCartLength}");
    // item = widget.quantity;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        centerTitle: true,
        backgroundColor: Color(0xffff9ff3),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).push(
        //         MaterialPageRoute(builder: (navigateContext) => NavigatorController())
        //     );
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.white,),
        // ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, ui, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: ui.getCartLength,
            itemBuilder: (ctx,index) {
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (navigate) => DetailScreen(
                        id: productProvider.getCartModelList[index].id,
                        nameProduct: productProvider.getCartModelList[index].name,
                        priceProduct: productProvider.getCartModelList[index].price,
                        regularPrice: productProvider.getCartModelList[index].price,
                        imageProduct: productProvider.getCartModelList[index].image,
                        description: "",
                        shortDescription: "",
                        quantity: productProvider.getCartModelList[index].quantity
                    ))
                  );
                },
                child: CardItems(
                    id: productProvider.getCartModelList[index].id,
                    index: index,
                    name: productProvider.getCartModelList[index].name,
                    image: productProvider.getCartModelList[index].image,
                    price: productProvider.getCartModelList[index].price,
                    quantity: productProvider.getCartModelList[index].quantity
                ),
              );
            }
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Text("Tiến hành đặt hàng", style: TextStyle(
              fontSize: 20,
              color: Colors.white
          ),),
          color: Colors.pinkAccent,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (navigateContext) => CheckOut())
            );
            // print("so luong cart screen ${widget.quantity}");
          },
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


  Widget _buildItemCard({
    required int id,
    required String name,
    required String image,
    required String price,
    required int quantity,
  }){

    int count = quantity;
    return Container(
      height: 150,
      margin: EdgeInsets.all(2.0),
      width: double.infinity,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                      image: NetworkImage("${image}"),
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
                          child: Text(reduceString(name)),
                        ),
                        Container(
                          height: 25,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text("Giá: ${formatCurrency.format(double.parse(price)).toString()} VNĐ ${id.toString()}"),
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
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                    print(quantity);
                                  }
                                },
                              ),
                              Text(
                                count.toString(),
                                style: TextStyle(fontSize: 20, color: Colors.white)
                              ),
                              GestureDetector(
                                child: Icon(Icons.add, color: Colors.white,),
                                onTap: () {
                                  print(id);
                                  if (quantity < 10) {
                                    setState(() {
                                      quantity++;
                                    });
                                    print(quantity);
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
                IconButton(onPressed: (){}, icon: Icon(Icons.close)),
              ]
            ),
          ]
        ),
      ),
    );
  }
}
