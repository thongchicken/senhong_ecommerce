import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition(start: 5, top: 7),
      badgeContent: Text("1", style: TextStyle(color: Colors.white),),
      child: IconButton(
        icon: Icon(Icons.notifications_none, color: Colors.white,),
        onPressed: (){},
      ),
    );
  }
}
