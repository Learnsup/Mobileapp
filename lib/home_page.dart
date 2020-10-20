import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:u_w_u/profile.dart';
import 'food_order.dart';
import 'slide_right.dart';
import 'slide_left.dart';
import 'history.dart';

class HomePageDesign extends StatefulWidget {
  @override
  _HomePageDesignState createState() => _HomePageDesignState();
}

class _HomePageDesignState extends State<HomePageDesign> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (0 != index) {
              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  SlideLeftRoute(page: FoodOrder()),
                );
              }
              if (index == 2) {
                Navigator.pushReplacement(
                    context, SlideLeftRoute(page: History()));
              }
              if (index == 3) {
                Navigator.pushReplacement(
                    context, SlideLeftRoute(page: Profile()));
              }
            }
          },
          items: [
            TitledNavigationBarItem(title: Text('Trang chủ'), icon: Icons.home),
            TitledNavigationBarItem(
                title: Text('Đặt món'), icon: Icons.food_bank),
            TitledNavigationBarItem(
                title: Text('Lịch sử'), icon: Icons.history),
            TitledNavigationBarItem(
                title: Text('Hồ sơ'), icon: Icons.person_outline),
          ]),
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 30),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red, //                   <--- border color
                    width: 5.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.local_hospital,
                    color: Colors.redAccent,
                    size: 34,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Cảnh báo sức khỏe",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Chỉ số BMI dưới trên trung bình",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "25.3",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Huyết áp cao",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "150/90 mmHg",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.redAccent,
                  size: 34,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Chẩn đoán",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red, //                   <--- border color
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Lượng snack tiêu thụ vượt mức trung bình",
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                " - Bạn đã tiêu thụ trung bình 120 gói mỗi ngày",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                " - Tăng nguy cơ xuất hiện bệnh tiểu đường và béo phì , tăng huyết áp",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red, //                   <--- border color
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Lượng nước ngọt tiêu thụ sắp đạt mức khuyến cáo so với người có tiền sử mắc bệnh tiểu đường",
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "< 180 mg/dL (10 mmol/l) ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                " - Bạn đã tiêu thụ trung bình 300 chai nước ngọt mỗi ngày",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              SizedBox(
                height: 7,
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          ),
        ]),
      ),
    );
  }
}

final String url =
    "https://i.imgur.com/SLtTVKr.png";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            color: Colors.blueAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.blue, blurRadius: 40, offset: Offset(0, 0))
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Trang chủ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Phạm Nguyên Anh",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 45),
                    Text(
                      "Khối",
                      style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "10",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Lớp",
                      style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "A5",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  print("//TODO: button clicked");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 45, 26, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.13),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(
                        child: Text("Chỉnh sửa" , style: TextStyle(fontSize: 16, color: Colors.indigo),),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white ,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 90);
    p.lineTo(size.width, size.height + 80);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
