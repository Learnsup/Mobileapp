import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:u_w_u/history.dart';
import 'package:u_w_u/profile.dart';
import 'food_page.dart';
import 'home_page.dart';
import 'slide_right.dart';
import 'slide_left.dart';
import 'history.dart';

class FoodOrder extends StatefulWidget {
  @override
  _FoodOrderState createState() => _FoodOrderState();
}

class _FoodOrderState extends State<FoodOrder>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
          activeColor: Colors.orange,
          currentIndex: 1,
          onTap: (index) {
            if (1 != index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  SlideRightRoute(page: HomePage()),
                );
              }
              if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  SlideLeftRoute(page: History()),
                );
              }
              if (index == 3) {
                Navigator.pushReplacement(
                  context,
                  SlideLeftRoute(page: Profile()),
                );
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Lựa chọn',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.emoji_food_beverage, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Thực đơn',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88D67),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Bữa chính',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Đồ ăn',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Thức uống',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                )
              ]),
          Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                CookiePage(),
                CookiePage(),
                CookiePage(),
              ]))
        ],
      ),
      floatingActionButton: Padding (
        padding: const EdgeInsets.only(bottom: 5.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFFF17532),
          child: Icon(Icons.fastfood),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
