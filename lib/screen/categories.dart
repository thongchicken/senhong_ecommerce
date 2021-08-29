import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhongecommerce/constants.dart';
import 'package:senhongecommerce/model/categories.dart';
import 'package:senhongecommerce/model/image_products.dart';
import 'package:senhongecommerce/model/product.dart';
import 'package:senhongecommerce/screen/detail_screen.dart';
import 'package:senhongecommerce/senhong_api_service.dart';
import 'package:senhongecommerce/widget/cart_notification_button.dart';
import 'package:senhongecommerce/widget/notifiaction_button.dart';
import 'package:intl/intl.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with AutomaticKeepAliveClientMixin{

  final formatCurrency = NumberFormat("#,##0");


  int _selectIndex = 2;
  ApiService apiService = ApiService();

  @override
  void initState() {
    apiService;
    print("initate categories");
    super.initState();
  }



  List<Product> productsList = [
    Product(id: 1, name: "Cải bẹ xanh", price: "14000", regularPrice: "14000", salePrice: "", images: [Images(id: 1, src: "cai-be-xanh.jpg")], description: "", shortDescription: ""),
    Product(id: 2, name: "Bí đao", price: "15000", regularPrice: "15000", salePrice: "", images: [Images(id: 2, src: "bi-dao.png")], description: "", shortDescription: ""),
    Product(id: 3, name: "Cải thìa", price: "23000", regularPrice: "23000", salePrice: "",images: [Images(id: 3, src: "cai-thia.jpg")], description: "", shortDescription: ""),
    Product(id: 4, name: "Bí rợ", price: "15000", regularPrice: "15000", salePrice: "", images: [Images(id: 4, src: "bi-ro.jpg")], description: "", shortDescription: ""),
    Product(id: 5, name: "Cà chua", price: "27000", regularPrice: "27000", salePrice: "", images: [Images(id: 5, src: "ca-chua4.jpg")], description: "", shortDescription: ""),
    Product(id: 6, name: "Cà rốt", price: "17000", regularPrice: "17000", salePrice: "", images: [Images(id: 6, src: "ca-rot.jpg")], description: "", shortDescription: ""),
    Product(id: 7, name: "Dưa hấu", price: "20000", regularPrice: "20000", salePrice: "", images: [Images(id: 7, src: "dua-hau.jpeg")], description: "", shortDescription: ""),
    Product(id: 8, name: "Dưa leo", price: "25000", regularPrice:"25000", salePrice: "", images: [Images(id: 8, src: "dua-leo.jpg")], description: "", shortDescription: "")
  ];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size sizeItems = MediaQuery.of(context).size * 0.2;
    Size sizeContents = MediaQuery.of(context).size * 0.8;
    print("Size categories ${sizeItems.width} Size contents ${sizeContents.width}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColorAppBar,
        title: const Text("Danh mục sản phẩm"),
        centerTitle: true,
        actions: const <Widget>[
          NotificationButton(),
          CartNotificationButton()
        ],
      ),
      body: _buildMainCategories()
    );
  }

  Widget _buildMainCategories() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCategoriesList(),
          _buildContentCategories(),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return FutureBuilder<List<SenHongCategory>>(
      future: apiService.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error"),);
        } else if (snapshot.hasData) {
          return _buildCategoriesItem(snapshot.data!);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _buildCategoriesItem(List<SenHongCategory> categoriesList) {
    return Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width * 0.25,
        child: ListView.builder(
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectIndex = categoriesList[index].id;
                });
                print("id category ${_selectIndex}");
              },
              child: _buildCategoriesIndex(
                id: categoriesList[index].id,
                image: categoriesList[index].image.src,
                name: categoriesList[index].name,
              ),
            );
          },
        )
    );
  }

  // *** sản phẩm hiển thị theo danh mục
  Widget _buildContentCategories() {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.75,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: _selectIndex == 2 ? productsList.length : 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DetailScreen(
                        id: productsList[index].id,
                        nameProduct: productsList[index].name,
                        priceProduct: productsList[index].price,
                        regularPrice: productsList[index].regularPrice,
                        imageProduct: productsList[index].images[0].src,
                        description: productsList[index].description,
                        shortDescription: productsList[index].shortDescription,
                        quantity: 1
                    ))
                );
              },
              child: _buildCardItemCategories(
                  name: productsList[index].name,
                  image: productsList[index].images[0].src,
                  price: productsList[index].price
              ),
            );
          }
      ),
    );
  }

  // ** build content category
  Widget _buildCardItemCategories({required String name, required String image, required String price}) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 0,
      child: Container(
        width: 150,
        alignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 115,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/products/$image")
                )
              ),
            ),
            Container(
              height: 30,
              width: 150,
              padding: EdgeInsets.all(5),
              alignment: AlignmentDirectional.center,
              child: Text("${formatCurrency.format(double.parse(price))} VNĐ", style: TextStyle(color: Colors.black))
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: 30,
              width: 150,
              alignment: AlignmentDirectional.center,
              child: Text("${name}", style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // ** build index item category
  Widget _buildCategoriesIndex({required int id, required String image, required String name}) {
    return Container(
      height: 100,
      width: 80,
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Container(
            height: 25,
            width: 90,
            padding: EdgeInsets.symmetric(vertical: 3),
            alignment: AlignmentDirectional.center,
            child: Text("${name}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 2
        ),
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}

