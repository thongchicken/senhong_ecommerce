import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senhongecommerce/model/cart_request_model.dart';
import 'package:senhongecommerce/provider/cart_provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:senhongecommerce/widget/cart_notification_button.dart';
import 'package:intl/intl.dart';
import '../provider/product_provider.dart';

class DetailScreen extends StatefulWidget {

  final int id;
  final String nameProduct;
  final String priceProduct;
  final String regularPrice;
  final String imageProduct;
  final String description;
  final String shortDescription;
  int quantity;

  DetailScreen({
    required this.id,
    required this.nameProduct,
    required this.priceProduct,
    required this.regularPrice,
    required this.imageProduct,
    required this.description,
    required this.quantity,
    required this.shortDescription,
  });


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with AutomaticKeepAliveClientMixin<DetailScreen>{
  late int item = 1;
  final formatCurrency = NumberFormat("#,##0", "en_VND");

  bool shortDesc = true;

  late ProductProvider productProvider;
  late CartProvider cartProvider;
  
  CartProduct cartProduct = CartProduct(productId: null, quantity: null);
  @override
  void initState() {
    productProvider = ProductProvider();
    cartProvider = CartProvider();
  }

  Widget _buildSizeProduct({required String size}) {
    return Container(
      height: 45,
      width: 45,
      color: Color(0xfff2f2f2),
      child: Center(
        child: Text(size, style: const TextStyle(fontSize: 15),),
      ),
    );
  }

  Widget _buildColorProduct({required Color color}) {
    return Container(
      height: 45,
      width: 45,
      color: color,
    );
  }



  @override
  Widget build(BuildContext context) {

    super.build(context);

    Size size = MediaQuery.of(context).size;

    productProvider = Provider.of<ProductProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        centerTitle: true,
        backgroundColor: Color(0xffff9ff3),
        actions: <Widget>[
          IconButton(
            onPressed: (){
            },
            icon: Icon(Icons.notifications_none, color: Colors.white,)
          ),
          CartNotificationButton()
        ],
      ),
      body: _buildMainProductDetail()
    );
  }

  Widget _buildMainProductDetail() {
    return ListView(
      children: [
        _buildImageProductDetail(),
        _buildRowInforProductDetail()
      ],
    );
  }

  Widget _buildImageProductDetail() {
    return Center(
      child: Container(
        width: double.infinity,
        child: Card(
          child: Container(
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage("${widget.imageProduct}")
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowInforProductDetail() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // name product
          Container(
            height: 65,
            child: Text("${widget.nameProduct}", style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                overflow: TextOverflow.clip
            ),),
          ),
          // end name product

          // size and color
          Container(
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // price product
                    const SizedBox(height: 15,),
                    Container(
                      width: 260,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${formatCurrency.format(double.parse(widget.priceProduct)).toString()} VNĐ", style: const TextStyle(
                            fontSize: 20,
                          ),),
                          Container(
                            height: 30,
                            width: 100,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.remove, color: Colors.white,),
                                  onTap: () {
                                    if (item > 1) {
                                      setState(() {
                                        item -= 1;
                                        widget.quantity = item;
                                      });
                                      print("item: ${item} quantity ${widget.quantity}");
                                    }
                                  },
                                ),
                                Text(item.toString(), style: TextStyle(fontSize: 20, color: Colors.white),),
                                GestureDetector(
                                  child: Icon(Icons.add, color: Colors.white,),
                                  onTap: () {
                                    if (item < 10) {
                                      setState(() {
                                        item += 1;
                                        widget.quantity = item;
                                      });
                                      print(item);
                                    }
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // end price product

                  ],
                ),
              ],
            ),
          ),
          // end size and color


          const SizedBox(height: 10,),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nhập mã giảm giá"
              ),
            ),
          ),

          const SizedBox(height: 15,),
          Container(
            height: 60,
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                productProvider.addToCart(
                    id: widget.id,
                    name: widget.nameProduct,
                    image: widget.imageProduct,
                    price: widget.priceProduct,
                    quantity: widget.quantity
                );
                showModalBottomSheet<void>(
                    context: context,
                    builder: (_) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  padding: EdgeInsets.all(10),
                                  child: const Text(
                                    "Đã Thêm Sản Phẩm Vào Giỏ Hàng",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  child: IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.cancel_outlined, color: Colors.red,),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(widget.imageProduct)
                                      )
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Cửa hàng: Nguyễn Nhứt Thống", style: TextStyle(fontSize: 16,)),
                                      Text("Tên sản phẩm: ${widget.nameProduct}̣", style: TextStyle(fontSize: 16,),),
                                      Text("Giá sản phẩm: ${formatCurrency.format(double.parse(widget.priceProduct)).toString()} VND", style: TextStyle(fontSize: 16,)),
                                      Text("Số lượng: ${widget.quantity}")
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                );
              },
              child: Text("Thêm vào giỏ hàng", style: TextStyle(
                  fontSize: 24,
                  color: Colors.white
              ),),
            ),
          ),


          // product description
          const SizedBox(height: 15,),
          const Text("Mô tả sản phẩm", style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 5,),
          Container(
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Html(data: shortDesc ? widget.shortDescription : widget.description)
                  ],
                ),
                Align(
                  child: GestureDetector(
                    child: Text(shortDesc ? "Xem thêm" : "Thu gọn", style: TextStyle(color: Colors.blue),),
                    onTap: () {
                      setState(() {
                        shortDesc = !shortDesc;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          // end product description

          const SizedBox(height: 15,),
          const Text("Sản phẩm tương tự", style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold
          ),),
          Container(

          )
        ],
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
