import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:u_w_u/home_page.dart';
import 'package:u_w_u/profile.dart';
import 'food_order.dart';
import 'slide_right.dart';
import 'slide_left.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

var foods = [
  'Phở bò',
  'Mì Quảng',
  'Bún',
  'Mì tôm',
  'Coca',
  'C2 Trà Xanh',
  'C2 Hồng Đào',
  '7UP ',
  'Bánh Socola Napati',
  'Snack',
  'Xí muội',
];

var foodsSelectIndex = math.Random();
var index;
var foodsSelect;
var color;

class _HistoryState extends State<History> {
  Widget appBarTitle = new Text("Tìm kiếm");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Color.fromRGBO(12, 123, 254, 100),
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Tìm kiếm...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Tìm kiếm");
                  }
                });
              },
            ),
          ]),
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {
            if (2 != index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  SlideRightRoute(page: HomePage()),
                );
              }
              if (index == 1) {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: FoodOrder()));
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
      body: makeBody,
    );
  }

  final makeBody = Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        index = foodsSelectIndex.nextInt(11);
        foodsSelect = foods[index];
        if ([0 , 1 , 2 , 3].contains(index)) {
          color = Colors.green;
        }
        else if ([4 , 5 , 6 , 7].contains(index)) {
          color = Colors.deepOrangeAccent;
        } else {
          color = Colors.amber;
        }

        final makeCard = Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Container(
              decoration: BoxDecoration(color: color),
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 3.0, color: Colors.white))),
                    child: Icon(
                      Icons.food_bank_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  title: Text(
                    foodsSelect,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.20),
                        child: Icon(
                          Icons.date_range,
                          color: Colors.greenAccent,
                          size: 22,
                        ),
                      ),
                      Text(" 24 / 10 / 2020",
                          style: TextStyle(color: Colors.white, fontSize: 16))
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.white, size: 30.0))),
        );
        return makeCard;
      },
    ),
  );
}
