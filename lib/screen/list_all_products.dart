import 'package:flutter/material.dart';
import 'package:senhongecommerce/screen/home.dart';

class ListAllProducts extends StatelessWidget {
  const ListAllProducts({Key? key}) : super(key: key);

  Widget _buildFeaturedProduct(
      {required String name,
      required double price,
      required String image,
      required double height,
      required double width}) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 1.0,
      child: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: height - 60,
              width: width - 25,
              // color: Colors.lightBlue,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/$image"))),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$price đ",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  // hàm hiển thị tất cả sản phẩm
  Widget _buildAllProducts() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.7, mainAxisSpacing: 10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildFeaturedProduct(
            name: "Samsung Galaxy note 10 Samsung Galaxy note 10",
            price: 7990000,
            image: "apple-watch-series3-band-100x100.jpg",
            height: 175,
            width: 165);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (navigate) => HomePage()),
              ) ;
            },
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          "Tất cả sản phẩm",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 600,
                child: _buildAllProducts(), // gridview products (2 item)
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
