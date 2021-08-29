
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhongecommerce/constants.dart';
import 'package:senhongecommerce/navigator_controller.dart';
import 'package:senhongecommerce/screen/login_screen.dart';
import 'package:senhongecommerce/screen/my_orders.dart';
import 'package:senhongecommerce/screen/my_products.dart';
import 'package:senhongecommerce/screen/profile_edit.dart';
import 'package:senhongecommerce/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Account extends StatefulWidget {

  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  SharedService sharedService = SharedService();
  String? firstName, lastName, email, address, city;
  bool logged = false;

  @override
  void initState() {
    getData();
    getUserInfor();
    // sharedService.removeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tài khoản"),
        centerTitle: true,
        backgroundColor: kPrimaryColorAppBar,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,)
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: _buildMainAccount(),
    );
  }

  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? named = prefs.getString("name");
    print(named);
  }

  Future getUserInfor() async {
    final prefs = await SharedPreferences.getInstance();
    firstName   = prefs.getString("first_name");
    lastName    = prefs.getString("last_name");
    email       = prefs.getString("email");
    address     = prefs.getString("address");
    city        = prefs.getString("city");

    firstName   = firstName!.replaceAll("\"", "");
    lastName    = lastName!.replaceAll("\"", "");
    email       = email!.replaceAll("\"", "");

    if (email != null) {
      setState(() {
        logged = true;
      });
    } else {
      setState(() {
        logged = false;
      });
    }
    print(logged);
  }

  // ** main account widget
  Widget _buildMainAccount() {
    return Container(
      height: double.infinity,
      child: ListView(
        children: [
          UserInfor(),
          const SizedBox(height: 10,),
          MyOders(),
          const SizedBox(height: 10,),
          VoteProdcuts(),
          const SizedBox(height: 10,),
          MyProducts(),
          const SizedBox(height: 10,),
          ExtensionOthers(),
          const SizedBox(height: 10,),
          OpenShopWithSenHong(),
          const SizedBox(height: 10,),
          LoginAndLogout(),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  // ** information for user login here
  Widget UserInfor() {
    return Container(
      height: 150,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: logged
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${lastName} ${firstName.toString()}", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
                const SizedBox(height: 5,),
                Text("Phone: 0917488548", style: TextStyle(color: Colors.black),),
                Text("Email: ${email}", style: TextStyle(color: Colors.black),),
                const SizedBox(height: 5,),
                Text("Địa chỉ nhận hàng", style: TextStyle(color: Colors.black),),
                Text("KTX khu A, Đại học Cần Thơ", style: TextStyle(color: Colors.black)),
                Text("3/2 Phường Xuân Khánh, Quận Ninh Kiều, Cần Thơ", style: TextStyle(color: Colors.black)),

              ],
            )
                : Center(child: Text("Bạn chưa đăng nhập", style: TextStyle(fontSize: 18),))
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/user-profile.png")
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (naviagate) => ProfileEdit())
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // ** orders for user in here
  Widget MyOders() {
    return Container(
      height: 120,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.all(8),
                child: Text("Đơn hàng của tôi", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (navigate) => MyOrdersScreen())
                    );
                  },
                  child: Text("Xem chi tiết", style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue
                  ),),
                )
              ),
            ],
          ),
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      child: IconButton(
                        onPressed: () => {
                          print("đóng gói")
                        },
                        icon: Icon(Icons.card_giftcard, size: 30, color: Colors.white,),
                      ),
                    ),
                    Text("Đang xử lý")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      child: IconButton(
                        onPressed: () => {
                          print("delivery")
                        },
                        icon: Icon(Icons.local_shipping_outlined, size: 30, color: Colors.white,),
                      ),
                    ),
                    Text("Đang vận chuyển")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey,
                      ),
                      child: IconButton(
                        onPressed: () => {
                          print("payment")
                        },
                        icon: Icon(Icons.payment_outlined, size: 30, color: Colors.white,),
                      ),
                    ),
                    Container(
                      child: Text("Chờ thanh toán"),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // **  vote for products in here
  Widget VoteProdcuts() {
    return GestureDetector(
      onTap: () => {
        print("Đánh giá sản phẩm")
      },
      child: Container(
        height: 60,
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.star_border, size: 35, color: Colors.yellow,),
          title: Text("Đánh giá sản phẩm", style: TextStyle(fontSize: 14, color: Colors.black),),
          trailing: Icon(Icons.keyboard_arrow_right_outlined, size: 30,),
        ),
      ),
    );
  }

  Widget MyProducts() {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (navigate) => MyProductsScreen())
        )
      },
      child: Container(
        height: 60,
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.shopping_bag_outlined, size: 35, color: Colors.green,),
          title: Text("Sản phẩm đã mua", style: TextStyle(fontSize: 14, color: Colors.black),),
          trailing: Icon(Icons.keyboard_arrow_right_outlined, size: 30,),
        ),
      ),
    );
  }

  Widget ExtensionOthers() {
    return Container(
      height: 150,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.all(10),
            child: Text("Tiện ích khác", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
          ),
          Container(
            height: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.headset_mic_outlined, color: Colors.lightBlue, size: 40,),
                    ),
                    Text("Hỗ trợ khách hàng")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.add_location_alt_outlined, color: Colors.lightBlue, size: 40,)
                    ),
                    Text("Địa chỉ nhận hàng")
                  ],
                ),
                GestureDetector(
                  onTap: () => {
                    print("Thông tin thanh toán")
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.payment_outlined, color: Colors.lightBlue, size: 40,)
                      ),
                      Text("Thông tin thanh toán")
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget OpenShopWithSenHong() {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (navigate) => NavigatorController())
        )
      },
      child: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: ListTile(
            leading: Icon(Icons.store_mall_directory_outlined, color: Colors.blue, size: 35,),
            title: Text("Bán hàng cùng Sen Hồng", style: TextStyle(fontSize: 15, color: Colors.black),),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30,),
          )
        ),
      ),
    );
  }

  Widget LoginAndLogout() {
    return GestureDetector(
      onTap: () => {
        if (logged) {
          sharedService.removeUser(),
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => super.widget)
          )
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (navigate) => LoginScreen())
          )
        }
      },
      child: Container(
        height: 60,
        color: Colors.white,
        child: ListTile(
          leading: logged
              ? const Icon(Icons.logout, size: 35, color: Colors.redAccent,)
              : const Icon(Icons.login, size: 35, color: Colors.lightBlue,),
          title: logged
              ? const Text("Đăng xuất", style: TextStyle(fontSize: 16, color: Colors.red),)
              : const Text("Đăng nhập", style: TextStyle(fontSize: 16, color: Colors.black),),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30,),
        ),
      ),
    );
  }


}
