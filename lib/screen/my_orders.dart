import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senhongecommerce/config.dart';
import 'package:senhongecommerce/model/order_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

  List<OrderModel> listOrders = [];
  List<LineItems> listItems = [];

  final formatCurrency = NumberFormat("#,##0");

  @override
  void initState() {
    loadOrders();
    print("CHIEU DAI: ${listOrders.length}");
  }

  Future loadOrders() async {

    String uri = Config.url + Config.orders + Config.key + Config.secret;
    var response = await http.get(Uri.parse(uri));
    print("init orders call ${response.statusCode}");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonOrders = jsonDecode(responseBody);
      for (var order in jsonOrders) {
        print("TOTAL: ${order['total']}");
        if (order['line_items'] != null) {
          for(var item in order['line_items']) {
            print("ITEMS: ${item}");
            listItems.add(
              LineItems(
                id: item['id'],
                name: item['name'],
                productId: item['product_id'],
                variationId: item['variation_id'],
                quantity: item['quantity'],
                subTotal: item['subtotal'],
                total: item['total'],
                price: item['price']
              )
            );
          }
        }
        listOrders.add(
          OrderModel(
            customerId: order['customer_id'],
            paymentMethod: order['payment_method'],
            paymentMethodTitle: order['payment_method_title'],
            transactionId: order['transaction_id'],
            orderId: order['id'],
            total: order['total'],
            orderNumber: order['order_key'],
            status: order['status'],
            orderDate: order['date_created'],
            lineItems: listItems
          )
        );
      }
      if (this.mounted) {
        setState(() {
          listItems;
          listOrders;
        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("Đơn hàng của tôi"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "Đang xử lý", icon: Icon(Icons.settings, color: Color(0xffd1ccc0), size: 40,),),
              Tab(text: "Đã thanh toán", icon: Icon(Icons.card_giftcard_outlined, color: Color(0xffd1ccc0), size: 40,),)
            ]
          )
        ),
        body: TabBarView(
          children: [
            // _buildOrderProgress(),
            // FutureBuilder<List<OrderModel>>(
            //   future: fetchOrders(http.Client()),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       print(" trang thai ket noi: ${snapshot.connectionState}");
            //       print("error is here: ${snapshot.error}");
            //       return Center(child: Text("Sorry! Something went wrong?"),);
            //     } else if (snapshot.hasData) {
            //       return _buildOrders(orders: snapshot.data!);
            //     } else {
            //       return Center(child: CircularProgressIndicator(),);
            //     }
            //   },
            // ),
            _buildOrderProgress(),
            _buildOrderProgress(),
          ],
        )
      ),
    );
  }

  Widget _buildOrderProgress() {
    return ListView.builder(
      itemCount: listOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(
          statusOrder: "Đơn hàng đang xử lý",
          items: listOrders[index].lineItems.length,
          total: listOrders[index].total
        );
      },
    );
  }

  Widget _buildOrderCard({required String statusOrder, required int items, required String total}) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          // status title
          Container(
            height: 40,
            width: size.width,
            child: Align(
              alignment: Alignment.center,
              child: Text(statusOrder, style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),),
            )
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
            indent: 15,
            endIndent: 25,
          ),

          // content orders
          Container(
            height: 100,
            width: size.width,
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/products/ca-rot.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ), Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          child: Text("Cà rốt, Bí đạo, Cà chua"),
                        ),
                        Container(
                          height: 20,
                          child: Text("Số sản phẩm: ${items}"),
                        ),
                        Container(
                          height: 20,
                          child: Text("Thanh toán: ${formatCurrency.format(double.parse(total))} VND"),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 5,),

          // button navigate
          Container(
            height: 60,
            width: size.width,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: (size.width * 0.5) - 8,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: Colors.blue
                    ),
                  ),
                  child: RaisedButton(
                    onPressed: () {print("mua lai");},
                    child: Text("Mua lại", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                  ),
                ),
                Container(
                  height: 60,
                  width: (size.width * 0.5) - 8,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  child: RaisedButton(
                    onPressed: () {print("xem chi tiet");},
                    child: Text("Xem chi tiết", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrders({required List<OrderModel> orders}) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        print("do dai ${orders.length}");
        return ListTile(
          title: Text(orders[index].orderNumber.toString()),
        );
      },
    );
  }

}


List<OrderModel> parseOrders(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  // print("parsed orders $parsed");
  return parsed.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
}

Future<List<OrderModel>> fetchOrders(http.Client client) async {
  final response = await client.get(Uri.parse("https://senhongecommerce.000webhostapp.com/wp-json/wc/v3/orders?consumer_key=ck_827ca126cb80609b4faed362528bd39dfd62e745&consumer_secret=cs_0a260c1904dd44f5cf44392cc46c4233d2f7f69c"));
  print("trang thai call order ${response.statusCode}");
  return compute(parseOrders, response.body);
}
