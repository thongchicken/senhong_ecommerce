import 'package:flutter/material.dart';
import 'package:senhongecommerce/screen/account.dart';
import 'package:senhongecommerce/screen/categories.dart';
import 'package:senhongecommerce/screen/home.dart';
import 'package:senhongecommerce/screen/wishlist_screen.dart';

class NavigatorController extends StatefulWidget {
  @override
  State<NavigatorController> createState() => _NavigatorControllerState();
}


class _NavigatorControllerState extends State<NavigatorController> with AutomaticKeepAliveClientMixin<NavigatorController>{
  int _selectIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Categories(),
    WishlistScreen(),
    Account()
  ];

  final pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        children: _widgetOptions,
        controller: pageController,
        onPageChanged: _onItemTapped,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xff17c0eb),),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category, color: Color(0xff17c0eb)),
              label: "Cateogires"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, color: Color(0xff17c0eb)),
              label: "Wishlist"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined, color: Color(0xff17c0eb)),
              label: "Account"
          )
        ],
        currentIndex: _selectIndex,
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        selectedItemColor: const Color(0xff17c0eb),
        backgroundColor: Colors.grey,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
