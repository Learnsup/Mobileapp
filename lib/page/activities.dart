import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:u_w_u/page/subpages/create_new_task_page.dart';
import 'subpages/done.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'subpages/next_project.dart';
import 'package:intl/intl.dart';
import 'subpages/music_player.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'consts/constants.dart';

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
  static int TimeInMin = 0;
  int TimeInSec = 0;
  int TimeInHour = 0;
  int TimeInDay = 0;
  Timer timer;
  bool InEvent = false;
  double SecPercent = 0;

  void getProject() {
    print("getPr");
    DateTime now = DateTime.now();
    int Hour = int.parse(DateFormat('HH').format(now));
    int Min = int.parse(DateFormat('mm').format(now));
    int Sec = int.parse(DateFormat('ss').format(now));

    String nextProjectDate = projectData[0]["date"];
    String nextProjectDay = nextProjectDate.substring(0, 2);
    String nextProjectMonth = nextProjectDate.substring(5, 7);
    String nextProjectYear = nextProjectDate.substring(10, 14);

    String nextProjectTime = projectData[0]["startTime"];
    String nextProjectHour = nextProjectTime.substring(0, 2);
    String nextProjectMins = nextProjectTime.substring(3, 5);

    DateTime nextProjectDateTime = DateTime.parse(
        "$nextProjectYear-$nextProjectMonth-$nextProjectDay\T$nextProjectHour:$nextProjectMins");
    Duration duration = nextProjectDateTime.difference(now);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    TimeInDay = duration.inDays;
    TimeInHour = int.parse(twoDigitHours);
    TimeInMin = int.parse(twoDigitMinutes);
    TimeInSec = int.parse(twoDigitSeconds);

    SecPercent = (1 /
        (TimeInDay * 62400 + TimeInHour * 3600 + TimeInMin * 60 + TimeInSec));
  }

  void getDuration() {
    print("getDr");

    DateTime now = DateTime.now();
    int realdate = (int.parse(DateFormat('dd').format(now)) - 20) * 24 * 3600 +
        int.parse(DateFormat('hh').format(now)) * 3600 +
        int.parse(DateFormat('mm').format(now)) * 60 +
        int.parse(DateFormat('ss').format(now));

    int tmprealdate = projectData[0]["realdate"];
    String tmpduration = projectData[0]["duration"];
    int diff = (tmprealdate +
            int.parse(tmpduration.substring(0, tmpduration.length - 1)) * 60) -
        realdate;

    Duration duration = Duration(seconds: diff);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    TimeInDay = duration.inDays;
    TimeInHour = int.parse(twoDigitHours);
    TimeInMin = int.parse(twoDigitMinutes);
    TimeInSec = int.parse(twoDigitSeconds);
    print("nope $diff");
    print(realdate);
    print(tmprealdate +
        int.parse(tmpduration.substring(0, tmpduration.length - 1)) * 60);
    print(TimeInHour);
    print(TimeInMin);
    print(TimeInSec);

    SecPercent = (1 /
        (TimeInDay * 62400 + TimeInHour * 3600 + TimeInMin * 60 + TimeInSec));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      DateTime now = DateTime.now();
      int tmprealdate;
      String tmpduration;
      int realdate =
          (int.parse(DateFormat('dd').format(now)) - 20) * 24 * 3600 +
              int.parse(DateFormat('hh').format(now)) * 3600 +
              int.parse(DateFormat('mm').format(now)) * 60;

      for (int i = 0; i < projectData.length; i++) {
        tmprealdate = projectData[i]["realdate"];
        tmpduration = projectData[i]["duration"];
        print("hey $tmpduration");
        print(InEvent);
        print(realdate);
        print(tmprealdate);
        print(tmpduration);
        print(int.parse(tmpduration.substring(0, tmpduration.length - 1)) * 60);
        if ((tmprealdate <= realdate &&
            realdate <=
                tmprealdate +
                    int.parse(
                            tmpduration.substring(0, tmpduration.length - 1)) *
                        60)) {
          print("help");
          InEvent = true;
          break;
        }
      }
      if (InEvent)
        getDuration();
      else
        getProject();

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (TimeInDay >= 0) {
            TimeInSec--;
            if (percent + SecPercent <= 1 && percent + SecPercent >= 0)
              percent += SecPercent;
            else
              percent = 0;
            if (TimeInSec < 0) {
              TimeInMin--;
              TimeInSec = 59;
              if (TimeInMin < 0) {
                TimeInMin = 59;
                TimeInHour--;
                if (TimeInHour < 0) {
                  TimeInHour = 23;
                  TimeInDay--;
                }
              }
            }
          } else {
            print(InEvent);
            print(TimeInDay);
            if (!InEvent) {
              getDuration();
            } else {
              getProject();
              projectData.removeAt(0);
            }
            InEvent = !InEvent;
          }
        });
      });
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        await LaunchApp.openApp(
            androidPackageName: 'idk.bro.u_w_u', openStore: false);
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        await LaunchApp.openApp(
            androidPackageName: 'idk.bro.u_w_u', openStore: false);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                        child: Column(
                          children: [
                            Text(
                              'You are in\nworking mode',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ButtonTheme(
                                minWidth: 100,
                                height: 60,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.blue,
                                  child: Text(
                                    'Okay',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: -60,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 50,
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 50,
                          ),
                        )),
                  ],
                ));
          },
        );
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
                            text:
                                '${TimeInDay != 0 ? "$TimeInDay days\n" : ""} $TimeInHour : $TimeInMin : $TimeInSec \n',
                            style: TextStyle(fontSize: 32)),
                        TextSpan(
                            text:
                                '${InEvent ? 'Working' : 'Till next project'}',
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
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "25",
                                          style: TextStyle(fontSize: 50.0),
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
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "5",
                                          style: TextStyle(fontSize: 50.0),
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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF545D68)),
          onPressed: () {
            audioPlayer.stop();
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
          Text('Working mode',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
              )),
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
                  child: Text('Music player',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Next project',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Done tasks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                )
              ]),
          Container(
              height: MediaQuery.of(context).size.height - 20.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                CountDownTimer(),
                MusicPlayer(),
                NextProject(),
                Done(),
              ]))
        ],
      ),
    );
  }
}
