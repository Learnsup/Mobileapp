import 'package:flutter/material.dart';
import 'consts/dates_list.dart';
import 'consts/light_colors.dart';
import 'consts/calendar_dates.dart';
import 'widgets/task_container.dart';
import 'subpages/create_new_task_page.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'profile.dart';
import 'settings.dart';
import 'home_page.dart';
import 'widgets/slide_right.dart';
import 'widgets/slide_left.dart';
import 'activities.dart';

class Schedule extends StatelessWidget {
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
        TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
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
                    context, SlideLeftRoute(page: Profile()));
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
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(
                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Add task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Productive Day, Sourav',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'April, 2020',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 58.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CalendarDates(
                      day: days[index],
                      date: dates[index],
                      dayColor: index == 0 ? LightColors.kRed : Colors.black54,
                      dateColor:
                      index == 0 ? LightColors.kRed : LightColors.kDarkBlue,
                    );
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: time.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${time[index]} ${time[index] > 8 ? 'PM' : 'AM'}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              _dashedText(),
                              TaskContainer(
                                title: 'Cày Rank',
                                subtitle:
                                'Đéo lên được vàng thì sống làm đ j cho nhục thế bạn',
                                boxColor: LightColors.kLightYellow2,
                              ),
                              _dashedText(),
                              TaskContainer(
                                title: 'Ngủ',
                                subtitle: 'UwU',
                                boxColor: LightColors.kLavender,
                              ),
                              TaskContainer(
                                title: 'Thở',
                                subtitle: 'Hoặc không',
                                boxColor: LightColors.kPalePink,
                              ),
                              TaskContainer(
                                title: 'Ăn',
                                subtitle:
                                'Hêhêhêhêhêhêhêhêhêhêhêhêhêhêhêhêhêhêhê',
                                boxColor: LightColors.kLightGreen,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
