import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senhongecommerce/provider/product_provider.dart';
import 'package:senhongecommerce/screen/cart_screen.dart';
import 'package:senhongecommerce/screen/detail_screen.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {

  @override
  State<CheckOut> createState() => _CheckOutState();
}

late ProductProvider productProvider;

class _CheckOutState extends State<CheckOut> {

  // @override
  // void initState() {
  //   widget.quantity;
  // }

  final formatCurrency = NumberFormat("#,##0", "en_VND");
  double price = 0;
  double saleOff = 150000;
  double totalPrice = 0;
  double shipping = 22000;

  @override
  void initState() {
    // price = double.parse(widget.price) * widget.quantity;
    setState(() {
      totalPrice = price - saleOff;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff9ff3),
        title: Text("Thanh toán", style: TextStyle(fontSize: 20),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (navigateContext) => CartScreen())
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white,),
            onPressed: () {},
          ),

        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(5.0),
        height: 60,
        child: RaisedButton(
          child: Text("Thanh toán", style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),),
          color: Colors.pinkAccent,
          onPressed: () {},
        ),
      ),
      body: _buildMainCheckOut()
    );
  }

  String reduceString(String name) {
    if (name.toString().length > 80) {
      name = name.substring(0, 64);
      name = name + "...";
    }
    return name;
  }

  Widget _buildMainCheckOut() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildDeliveryAddress(),
          _buildItemOrders(),
          // _buildGridView(),
          _buildBillingDetail(),
        ],
      ),
    );
  }



  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: const ClampingScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.all(5),
          color: Colors.blue,
        );
      }
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text("Địa chỉ nhận hàng", style: TextStyle(fontSize: 14, color: Colors.lightBlue),),
            Text("Nguyễn Nhứt Thống - 0917488548", style: TextStyle(fontSize: 15, color: Colors.black),),
            Text("KTX Khu A, Đại học Cần Thơ", style: TextStyle(fontSize: 15, color: Colors.black),),
            Text("Phường Xuân Khánh, Quận Ninh Kiều, Cần Thơ", style: TextStyle(fontSize: 15, color: Colors.black),)
          ],
        )
    );
  }

  Widget _buildItemOrders() {
    return Container(
      height: 450,
      child: ListView.builder(
        itemCount: productProvider.getCartLength,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => _buildItemCard(
            id: productProvider.getCartModelList[index].id,
            name: productProvider.getCartModelList[index].name,
            image: productProvider.getCartModelList[index].image,
            price: productProvider.getCartModelList[index].price,
            quantity: productProvider.getCartModelList[index].quantity
        ),
      ),
    );
  }

  Widget _buildBillingDetail() {

    double price = 0;
    double items = 0;
    for (int i=0; i<productProvider.getCartLength; i++) {
      items = productProvider.getCartModelList[i].quantity * double.parse(productProvider.getCartModelList[i].price);
      price += items;
    }

    if (price >= 10000000) {
      setState(() {
        saleOff = price * 0.03;
      });
    } else if (price >= 15000000) {
      setState(() {
        saleOff = price * 0.05;
      });
    } else if (price >= 20000000) {
      setState(() {
        saleOff = price * 0.1;
      });
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Thành tiền ", style: TextStyle(fontSize: 18,),),
              Text("${formatCurrency.format(price)} vnđ", style: const TextStyle(fontSize: 18,),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Giảm giá ", style: TextStyle(fontSize: 18,),),
              Text("${formatCurrency.format(saleOff)} vnđ", style: const TextStyle(fontSize: 18,),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Phí vận chuyển ", style: TextStyle(fontSize: 18,),),
              Text("${formatCurrency.format(shipping)} vnđ", style: const TextStyle(fontSize: 18,),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tổng cộng ", style: TextStyle(fontSize: 18,),),
              Text("${formatCurrency.format(price - (saleOff + shipping))} vnđ", style: const TextStyle(fontSize: 18,),)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItemCard({
    required int id,
    required String name,
    required String image,
    required String price,
    required int quantity}){
    return Card(
      child: Container(
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
                        image: NetworkImage("${image}"),
                      )
                  ),
                ), Expanded(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${reduceString(name)}"),
                          Text("Giá: ${formatCurrency.format(double.parse(price)).toString()} VNĐ"),
                          Container(
                            height: 30,
                            width: 100,
                            padding: const EdgeInsets.all(4),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Số lượng: "),
                                Text(quantity.toString())
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
