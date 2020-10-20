import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:u_w_u/history.dart';
import 'home_page.dart';
import 'slide_right.dart';
import 'history.dart';
import 'food_order.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final titles = [
      'Cân nặng',
      'Chiều cao',
      'Thị lực',
      'Huyết áp',
      "Lượng đường huyết",
      'Nồng độ axit uric',
      'Tiền sử bệnh',
      'Bệnh tất / dị chứng bẩm sinh',
    ];

    final subtitles = [
      '90 kg',
      '170 cm',
      '120 / 10',
      '150 / 90 mmHg',
      "92mg / dl",
      '75 mg / l',
      'Tiểu đường , sốt xuất huyết',
      'Không có',
    ];

    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 3,
          onTap: (index) {
            if (3 != index) {
              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  SlideRightRoute(page: FoodOrder()),
                );
              }
              if (index == 2) {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: History()));
              }
              if (index == 0) {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: HomePage()));
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
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 80,
              child: ListView(children: [
                Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle_outlined,
                          size: 34,
                        ),
                        title: Text(
                          titles[index],
                          style: TextStyle(fontSize: 17),
                        ),
                        subtitle: Text(
                          subtitles[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
        },
      ),
    );
    throw UnimplementedError();
  }
}
