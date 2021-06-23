import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'schedule.dart';
import 'settings.dart';
import 'home_page.dart';
import 'widgets/slide_right.dart';
import 'widgets/slide_left.dart';
import 'activities.dart';
import 'consts/light_colors.dart';
import 'dart:math' as math;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {
            if (2 != index) {
              if (index == 0) {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: HomePage()));
              }
              if (index == 1) {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: Schedule()));
              }
              if (index == 3) {
                Navigator.pushReplacement(
                    context, SlideLeftRoute(page: Settings()));
              }
            }
          },
          items: [
            TitledNavigationBarItem(title: Text('Trang chủ'), icon: Icons.home),
            TitledNavigationBarItem(
                title: Text('Lịch trình'), icon: Icons.schedule),
            TitledNavigationBarItem(
                title: Text('Hồ sơ'), icon: Icons.person_outline),
            TitledNavigationBarItem(
                title: Text('Cài đặt'), icon: Icons.settings),
          ]),
      floatingActionButton: Padding (
        padding: const EdgeInsets.only(bottom: 5.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Activities()),
            );
          },
          backgroundColor: Color(0xFFF17532),
          child: Icon(Icons.book),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                    color: Colors.greenAccent, //                   <--- border color
                    width: 5.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.orange,
                    size: 34,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Thông tin cá nhân",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Tuổi",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "69",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Địa chỉ",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Chịu",
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
                  Icons.history,
                  color: Colors.redAccent,
                  size: 34,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Lịch sử",
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
                        "23 - 6 - 2022",
                        style: TextStyle(fontSize: 20),
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
                " - Bạn đã hoàn thành 100% công việc đã dự định với hiệu suất hiệu quả : ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "     Vẽ / Đọc sách / Thiết kế",
                style: TextStyle(fontSize: 17),
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
                        "22 - 6 - 2022",
                        style: TextStyle(fontSize: 20),
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
                " - Bạn đã hoàn thành 75% công việc với hiệu suất trung bình",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "     Làm BTVN / Học tập / Xây dựng app",
                style: TextStyle(fontSize: 17),
              ),SizedBox(
                height: 7,
              ),
              Text(
                "      Bỏ qua : Ngủ",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            color: LightColors.kLavender,
            boxShadow: [
              BoxShadow(
                  color: Colors.blueAccent, blurRadius: 40, offset: Offset(0, 0))
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "\n Hồ sơ cá nhân",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 26,
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
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 27),
                    Text(
                      "Khối",
                      style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "10",
                      style: TextStyle(fontSize: 26, color: Colors.black),
                    ),
                    SizedBox(height: 27),
                    Text(
                      "Lớp",
                      style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "A5",
                      style: TextStyle(fontSize: 26, color: Colors.black),
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
                  padding: const EdgeInsets.fromLTRB(0, 13, 50, 0),
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

