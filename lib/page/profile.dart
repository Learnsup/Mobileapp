import 'package:draw_graph/models/feature.dart';
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
import 'package:draw_graph/draw_graph.dart';
import 'subpages/history.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Feature> features = [
    Feature(
      title: "Efficiency",
      color: Colors.blue,
      data: [0.7, 0.9, 0.5, 0.4, 0.7, 0.7, 0.8],
    ),
    Feature(
      title: "Tasks done",
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3, 0.8, 0.9],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      resizeToAvoidBottomInset: false,
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
            TitledNavigationBarItem(
                title: Text(
                  'Homepage',
                  style: TextStyle(fontSize: 12),
                ),
                icon: Icons.home),
            TitledNavigationBarItem(
                title: Text('Schedule'), icon: Icons.schedule),
            TitledNavigationBarItem(
                title: Text('Profile'), icon: Icons.person_outline),
            TitledNavigationBarItem(
                title: Text('Settings'), icon: Icons.settings),
          ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Activities()),
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
                    color: Colors.greenAccent,
                    //                   <--- border color
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
                        "Personal information",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Age",
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
                "Address",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Idk bro",
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
                      "History",
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
                        "17 / 6 / 2022 - 23 / 6 / 2022 \n (Week 3)",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => History()));
                },
                child: LineGraph(
                  features: features,
                  size: Size(620, 400),
                  labelX: [
                    'Day 1',
                    'Day 2',
                    'Day 3',
                    'Day 4',
                    'Day 5',
                    'Day 6',
                    'Day 7'
                  ],
                  labelY: ['20%', '40%', '60%', '80%', '100%'],
                  showDescription: true,
                  graphColor: Colors.black,
                  graphOpacity: 0.2,
                  verticalFeatureDirection: true,
                  descriptionHeight: 180,
                ),
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

final String url = "https://i.imgur.com/SLtTVKr.png";

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
                  color: Colors.blueAccent,
                  blurRadius: 40,
                  offset: Offset(0, 0))
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "\n Profile",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
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
                      "Jesus Christ",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 27),
                    Text(
                      "Grade",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "10",
                      style: TextStyle(fontSize: 26, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Class",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "A5",
                      style: TextStyle(fontSize: 26, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 32, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 16, color: Colors.indigo),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
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

    p.lineTo(0, size.height - 60);
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
