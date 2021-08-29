import 'package:flutter/material.dart';
import 'package:senhongecommerce/widget/notifiaction_button.dart';


class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          NotificationButton()
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        maxRadius: 65,
                        backgroundImage: AssetImage("assets/images/user-profile.png"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 220, top: 80),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.edit, color: Colors.black,),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 450,
              width: double.infinity,
              child: edit == true
                  ? Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSingleTextFormField(name: "Nguyễn Nhứt Thống"),
                            _buildSingleTextFormField(name: "nguyennhutthong.dev@gmail.com"),
                            _buildSingleTextFormField(name: "0917488548"),
                            _buildSingleTextFormField(name: "TP. Cần Thơ, tỉnh Cần Thơ"),
                            _buildSingleTextFormField(name: "Phường Xuần Khánh, Quận Nình Kiều"),
                            _buildSingleTextFormField(name: "KTX khu A Đại học Cần Thơ"),

                          ],
                        ),
                      ),
                    ],
                  )
                  :  Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSingleContact(startText: "Name", endText: "Nguyễn Nhứt Thống"),
                              _buildSingleContact(startText: "Email", endText: "nguyennhutthong.dev@gmail.com"),
                              _buildSingleContact(startText: "Điện thoại", endText: "0917488548"),
                              _buildSingleContact(startText: "Tỉnh/Thành phố", endText: "TP. Cần Thơ"),
                              _buildSingleContact(startText: "Địa chỉ 1", endText: "Phường Xuân Khánh, Quận Ninh Kiều"),
                              _buildSingleContact(startText: "Địa chỉ 2", endText: "KTX khu A Đại học Cần Thơ"),
                            ],
                          ),
                          ),
                      ],
                  )
            ),
            SizedBox(height: 10,),
            Container(
              height: 45,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    edit = true;
                  });
                },
                child: Text("Edit profile", style: TextStyle(color: Colors.white),),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSingleContact({required String startText, required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(startText, style: TextStyle(fontSize: 13, color: Colors.black),),
            Text(endText, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),)
          ],
        ),
      ),
    );
  }

  Widget _buildSingleTextFormField({required String name}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
    );
  }
}
