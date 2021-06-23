import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'subpages/done.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'subpages/next_project.dart';
import 'package:intl/intl.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(184, 189, 245, 0.7)
          ],
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(172, 182, 219, 0.7)
          ],
          [
            Color.fromRGBO(72, 73, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(190, 238, 246, 0.7)
          ],
        ],
        durations: [19440, 10800, 6000],
        heightPercentages: [0.03, 0.01, 0.02],
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 25,
      backgroundColor: Colors.blue[50],
    );
  }
}

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with WidgetsBindingObserver {
  double percent = 0;
  static int TimeInMin = 25;
  int TimeInSec = TimeInMin * 60;
  int TimeInHour;
  Timer timer;
  bool InEvent = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      DateTime now = DateTime.now();
      int Hour = int.parse(DateFormat('HH').format(now));
      int Min = int.parse(DateFormat('mm').format(now));
      int Sec = int.parse(DateFormat('ss').format(now));

      void diff(int Cnt) {
        if (Cnt == 10 || Cnt == 17)
          InEvent = true;
        else
          InEvent = false;

        TimeInHour = Cnt - Hour;
        TimeInMin = 60 - Min;
        TimeInSec = 60 - Sec;

        if (TimeInSec != 60) {
          TimeInHour -= 1;
          TimeInMin -= 1;
        } else {
          TimeInSec = 0;
          if (TimeInMin != 60) {
            TimeInHour -= 1;
          } else
            TimeInMin = 0;
        }
      }

      if (7 <= Hour && Hour < 10)
        diff(10);
      else if (10 <= Hour && Hour < 14)
        diff(14);
      else if (14 <= Hour && Hour < 17)
        diff(17);
      else if (0 <= Hour && Hour < 7)
        diff(7);
      else
        diff(31);

      double SecPercent =
          (1 / (TimeInHour * 3600 + TimeInMin * 60 + TimeInSec));
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (TimeInHour >= 0) {
            TimeInSec--;
            if (TimeInSec == -1) {
              TimeInMin--;
              TimeInSec = 59;
              if (TimeInMin == -1) {
                TimeInMin = 59;
                TimeInHour--;
              }
            }
            if (percent < 1) {
              percent += SecPercent;
            } else {
              percent = 1;
            }
          } else {
            percent = 1;
            timer.cancel();
          }
        });
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Counter",
                    style: TextStyle(color: Color(0xff002c3e), fontSize: 35.0),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    percent: percent,
                    animation: true,
                    lineWidth: 20.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    animateFromLastPercent: true,
                    radius: 250.0,
                    progressColor: Colors.white,
                    center: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: '$TimeInHour : $TimeInMin : $TimeInSec \n',
                            style: TextStyle(fontSize: 32)),
                        TextSpan(
                            text:
                                '${InEvent ? 'Đang làm việc' : 'Cho đến lúc làm việc'}',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Study Time",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "25",
                                          style: TextStyle(fontSize: 60.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Break Time",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "5",
                                          style: TextStyle(fontSize: 60.0),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities>
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Learnsup',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timelapse, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Làm việc',
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
                  child: Text('Timer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Kế tiếp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Đã hoàn thành',
                      textAlign: TextAlign.center,
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
                CountDownTimer(),
                NextProject(),
                Done(),
              ]))
        ],
      ),
    );
  }
}
