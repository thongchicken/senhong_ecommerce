import 'dart:convert';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhongecommerce/config.dart';
import 'package:senhongecommerce/constants.dart';
import 'package:senhongecommerce/model/categories.dart';
import 'package:senhongecommerce/model/image_products.dart';
import 'package:senhongecommerce/model/product.dart';
import 'package:senhongecommerce/screen/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:senhongecommerce/screen/signup.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:intl/intl.dart';
import 'package:senhongecommerce/widget/cart_notification_button.dart';
import 'package:senhongecommerce/widget/notifiaction_button.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  late GlobalKey<ScaffoldState> _key = GlobalKey();

  final formatCurrency = NumberFormat("#,##0");

  List<Product> listProducts = [];
  List<SenHongCategory> listCategories = [];
  ApiService apiService = ApiService();

  AsyncMemoizer memCache = AsyncMemoizer();

  @override
  void initState() {
    loadProducts();
    print("init state home ");
    super.initState();
  }

  Future loadProducts() async {
    String uri = Config.url + Config.products + Config.key + Config.secret;
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print("call products");
      var jsonProducts = json.decode(responseBody);
      for(var product in jsonProducts) {
        listProducts.add(
          Product(
            id: product['id'],
            name: product['name'],
            price: product['price'],
            regularPrice: product['regular_price'],
            salePrice: product['sale_price'],
            images: [Images(id: product['images'][0]['id'], src: product['images'][0]['src'])],
            description: product['description'],
            shortDescription: product['short_description']
          )
        );
      }
      if(this.mounted) {
        setState(() {
          listProducts;
        });
      }
    } else {
      print("Something went wrong");
    }
  }


  int discount({required double price, required double salePrice}) {
    double prices = 0;
    double saleoff = 0;
    prices = (price - salePrice );
    saleoff = ((prices / price) * 100);
    return saleoff.round();
  }



  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    super.build(context);
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      // drawer: _buildDrawer(),
      appBar: AppBar(
        title: const Text(
          "Sen Hồng",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.normal,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kPrimaryColorAppBar,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu, color: Colors.white),
        //   onPressed: () {
        //     _key.currentState?.openDrawer();
        //   }),
        actions: const <Widget>[
          NotificationButton(),
          CartNotificationButton(),
        ],
      ),
      body: _buildMainHomePage(),
    );
  }

  Widget _buildFeaturedProduct({
    required String name,
    required String price,
    required String image,
    required double height,
    required double width
  }) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 0,
      child: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Visibility(
              visible: false,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text("Sale off", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Container(
              height: height - 40,
              width: width - 15,
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
              height: 5,
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

  // all products
  Widget _buildAllProducts() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.6,
      ),
      physics: const ClampingScrollPhysics(),
      itemCount: listProducts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (navigateContext) => DetailScreen(
                  id: listProducts[index].id,
                  nameProduct: listProducts[index].name.toString(),
                  priceProduct: listProducts[index].price,
                  regularPrice: listProducts[index].regularPrice,
                  imageProduct: listProducts[index].images[0].src.toString(),
                  description: listProducts[index].description,
                  shortDescription: listProducts[index].shortDescription,
                  quantity: 1,
                ))
            );
          },
          child: _buildHomeProduct(
              id: listProducts[index].id,
              name: listProducts[index].name.toString(),
              price: listProducts[index].price,
              regularPrice: listProducts[index].regularPrice,
              salePrice: listProducts[index].salePrice,
              image: listProducts[index].images[0].src.toString(),
              description: listProducts[index].description,
              shortDescription: listProducts[index].shortDescription,
              quantity: 1
          ),
        );
      },
    );
  }

  // *** slider using carousel ***
  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
      ),
      items: [1, 2, 3, 4].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/banner/$i.jpg")),
                // color: Colors.amber
              ),
              // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
            );
          },
        );
      }).toList(),
    );
  }

  // *** _build
  Widget _buildListFeaturedCategories() {
    return Container(
      child: FutureBuilder<List<SenHongCategory>>(
        future: apiService.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"),);
          } else if (snapshot.hasData) {
            return _buildHomeFeaturedCategories(snapshot.data!);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  // *** categories ***
  Widget _buildHomeFeaturedCategories(List<SenHongCategory> listCategories) {
    return Container(
      height: 140,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listCategories.length,
        itemBuilder: (context, index) {
          return _buildProductsCategory(image: listCategories[index].image.src, name: listCategories[index].name);
        },
      ),
    );
  }

  // *** product follow
  Widget _buildProductFollow() {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildFeaturedProduct(
              name: "Dưa hấu",
              price: "9990000",
              image: "dua-hau.jpeg",
              height: 200,
              width: 165),
          _buildFeaturedProduct(
              name: "Cà rốt",
              price: "7990000",
              image: "ca-rot.jpg",
              height: 200,
              width: 165),
          _buildFeaturedProduct(
              name: "Cảy bẹ xanh",
              price: "4990000",
              image: "cau-be-xanh.jpg",
              height: 200,
              width: 165),
        ],
      ),
    );
  }

  // *** product trend
  Widget _buildTrendProducts() {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            child: _buildFeaturedProduct(
                name: "Bí đao",
                price: "22000",
                image: "bi-dao.png",
                height: 200,
                width: 165),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (navigateContext) => DetailScreen(
                    id: 1,
                    nameProduct: "Bí đao",
                    priceProduct: "22000",
                    regularPrice: "22000",
                    imageProduct: "bi-dao.png",
                    description: "Description",
                    shortDescription: "Short Description",
                    quantity: 1,
                  ))
              );
            },
          ),
          GestureDetector(
            child: _buildFeaturedProduct(
                name: "Bí rợ",
                price: "25000",
                image: "bi-ro.jpg",
                height: 200,
                width: 165),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (navigateContext) => DetailScreen(
                    id: 2,
                    nameProduct: "Bí rợ",
                    priceProduct: "25000",
                    regularPrice: "25000",
                    imageProduct: "bi-ro.jpg",
                    description: "Description",
                    shortDescription: "Short Description",
                    quantity: 1,
                  ))
              );
            },
          ),
          GestureDetector(
            child: _buildFeaturedProduct(
                name: "Cà chua",
                price: "28000",
                image: "ca-chua4.jpg",
                height: 200,
                width: 165),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (navigateContext) => DetailScreen(
                    id: 3,
                    nameProduct: "Cà chua",
                    priceProduct: "28000",
                    regularPrice: "28000",
                    imageProduct: "ca-chua4.jpg",
                    description: "Description",
                    shortDescription: "Short description",
                    quantity: 1,
                  ))
              );
            },
          ),

        ],
      ),
    );
  }

  // *** main home page
  Widget _buildMainHomePage() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        // padding: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          shrinkWrap: true,
          children: [

            Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      hintText: "Nhập tên sản phẩm...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  )
                ],
              ),
            ),
            _buildCarouselSlider(),

            _buildTitle(title: "Sản phẩm thịnh hành"),
            _buildTrendProducts(),

            _buildTitle(title: "Danh mục nổi bật"),
            _buildListFeaturedCategories(),

            _buildTitle(title: "Có thể bạn quan tâm"),
            _buildProductFollow(),

            _buildTitle(title: "Tất cả sản phẩm"),
            _buildAllProducts()

          ],
        )
    );
  }

  Widget _buildProductsCategory({required String name, required String image}) {
    return Container(
      height: 140,
      width: 130,
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 130,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 15
                )
              ],
              image: DecorationImage(
                image: NetworkImage(image)
              )
            ),
          ),
          SizedBox(height: 5,),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),

    );
  }

  Widget _buildTitle({required String title}) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeProduct(
      { required int id,
        required String name,
        required String price,
        required String regularPrice,
        required String salePrice,
        required String image,
        required String description,
        required String shortDescription,
        required int quantity,
      }) {

    double parsePrice = double.parse(price);
    double parseRegularPrice = double.parse(regularPrice);

    return Card(
      shadowColor: Colors.grey,
      elevation: 0,
      child: Container(
        height: 175,
        width: 170,
        // color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            // ** label sale off
            Container(
              height: 30,
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Visibility(
                      visible: salePrice != "",
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("GIẢM GIÁ", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),


                  // ** Add to wishlist
                  Container(
                    child: Visibility(
                      visible: true,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          padding: EdgeInsets.all(3),
                          icon: Icon(Icons.favorite_border, color: Colors.green,),
                          onPressed: () {
                            print("Add to wishlist");
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // ** Image product list at home page
            Container(
              height: 115,
              width: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("$image")
                ),
                // color: Colors.blueGrey
              ),
            ),

            // ** price product list at home page
            Container(
                height: 40,
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${formatCurrency.format(double.parse(regularPrice)).toString()} VND ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5,),
                    parseRegularPrice > parsePrice
                        ? Text(
                            "${formatCurrency.format(double.parse(price)).toString()} VND",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                          )
                        : Text(""),
                  ],
                )
            ),

            // ** Name product list at home page
            Container(
              height: 65,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(name, style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

}



