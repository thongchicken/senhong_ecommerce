import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:senhongecommerce/provider/product_provider.dart';
import 'package:senhongecommerce/screen/cart_screen.dart';

class CartNotificationButton extends StatefulWidget {
  const CartNotificationButton({Key? key}) : super(key: key);

  @override
  State<CartNotificationButton> createState() => _CartNotificationButtonState();
}

late ProductProvider productProvider;

class _CartNotificationButtonState extends State<CartNotificationButton> {
  @override
  Widget build(BuildContext context) {

    productProvider = Provider.of<ProductProvider>(context);

    return productProvider.getCartLength > 0 ? BadgesHaveContent() : BadgesNoContent();
  }

  Widget BadgesHaveContent() {
    return Badge(
      position: BadgePosition(start: 5, top: 7),
      badgeContent: Text(productProvider.getCartLength.toString(), style: TextStyle(color: Colors.white),),
      child: IconButton(
        icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (navigateContext) => CartScreen())
          );
        },
        color: Color(0xff4cd137),
      ),
    );
  }

  Widget BadgesNoContent() {
    return Badge(
      child: IconButton(
        icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (navigateContext) => CartScreen())
          );
        },
        color: Color(0xff4cd137),
      ),
    );
  }
}
