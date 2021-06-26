import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import '../consts/light_colors.dart';
import '../widgets/top_container.dart';
import '../widgets/back_button.dart';
import '../widgets/my_text_field.dart';
import '../home_page.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../consts/constants.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:u_w_u/main.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPage createState() => _CreateNewTaskPage();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class _CreateNewTaskPage extends State<CreateNewTaskPage> {
  TimeOfDay time;

  Future<void> ScheduleNotification(int duration) async {
    print(duration);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'You have unfinished task',
        'Get back to your work',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: duration)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        SecondPage(receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.pushNamed(context, '/secondPage');
    });
  }

  @override
  void dispose() {
    titleController.dispose();

    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  String getText() {
    if (time == null) {
      return 'Pick a time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() {
      time = newTime;
      startTimeController.text = getText();
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Start time : ${startTimeController.text}')));
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 6),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd / MM / yyyy').format(selectedDate);
      });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Date : ${dateController.text}')));
  }

  List<bool> chose = [false, false, false, false, false];
  List<String> name = ["APP1", "APP2", "APP3", "NOTES1", "NOTES2"];

  Widget _myChip(String name, int id) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new InkWell(
        child: new Chip(
            label: new Text(
              name,
              style:
                  new TextStyle(color: chose[id] ? Colors.white : Colors.black),
            ),
            backgroundColor: chose[id] ? Colors.black : Colors.white),
        onTap: () {
          setState(() {
            chose[id] = !chose[id];
          });
        },
      ),
    );
  }

  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(
                        label: 'Title',
                        controller: titleController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              label: 'Date',
                              icon: downwardIcon,
                              controller: dateController,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: HomePage.calendarIcon(),
                          ),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        label: 'Start Time',
                        controller: startTimeController,
                      )),
                      InkWell(
                        onTap: () {
                          pickTime(context);
                        },
                        child: HomePage.clockIcon(),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: MyTextField(
                          label: 'Duration',
                          controller: durationController,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var resultingDuration = await showDurationPicker(
                            context: context,
                            initialTime: Duration(minutes: 30),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Duration : ${resultingDuration.inMinutes}p')));
                          setState(() {
                            durationController.text =
                                resultingDuration.inMinutes.toString() + "p";
                          });
                        },
                        child: HomePage.durationIcon(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    label: 'Description',
                    minLines: 3,
                    maxLines: 3,
                    controller: descriptionController,
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 15,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            _myChip("APP1", 0),
                            _myChip("APP2", 1),
                            _myChip("APP3", 2),
                            _myChip("NOTES1", 3),
                            _myChip("NOTES2", 4),
                            Chip(
                              avatar: Icon(
                                Icons.local_hospital,
                                color: Colors.white,
                                size: 20,
                              ),
                              label: Text("Add new category"),
                              backgroundColor: LightColors.kRed,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (titleController.text == "" ||
                          dateController.text == "" ||
                          startTimeController.text == "" ||
                          durationController.text == "") {
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
                                      height: 240,
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 70, 10, 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'You haven\'t input in requirement field',
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
                                                        color: Colors.white,
                                                        fontSize: 20),
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
                      } else {
                        bool duplicate = false;
                        int tmprealdate;
                        String tmpduration;
                        int realdate =
                            ((int.parse(DateFormat('dd').format(selectedDate)) -
                                                20) *
                                            24 +
                                        int.parse(startTimeController.text
                                            .substring(0, 2))) *
                                    3600 +
                                int.parse(startTimeController.text
                                        .substring(3, 5)) *
                                    60;
                        int realdateduration = realdate +
                            int.parse(durationController.text.substring(
                                    0, durationController.text.length - 1)) *
                                60;
                        for (int i = 0; i < projectData.length; i++) {
                          tmprealdate = projectData[i]["realdate"];
                          tmpduration = projectData[i]["duration"];
                          //print("$tmpduration  $tmprealdate  $realdate");
                          if ((tmprealdate < realdate &&
                                  realdate <
                                      tmprealdate +
                                          int.parse(tmpduration.substring(
                                                  0, tmpduration.length - 1)) *
                                              60) ||
                              (tmprealdate < realdateduration &&
                                  realdateduration <
                                      tmprealdate +
                                          int.parse(tmpduration.substring(
                                                  0, tmpduration.length - 1)) *
                                              60)) {
                            duplicate = true;
                            break;
                          }
                        }
                        if (duplicate) {
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
                                        height: 240,
                                        width: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 70, 10, 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                'There is already a tasks at this time ',
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    color: Colors.blue,
                                                    child: Text(
                                                      'Okay',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
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
                        } else {
                          String allCategories = "";
                          List<String> names = [];
                          for (int i = 0; i <= 4; i++) {
                            if (chose[i] == true) {
                              names.insert(0, name[i]);
                              if (allCategories == "")
                                allCategories += name[i];
                              else
                                allCategories += "  |  " + name[i];
                            }
                          }
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
                                        height: 420,
                                        width: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 70, 10, 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Confirm add tasks',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${titleController.text}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${dateController.text}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${startTimeController.text} trong vòng ${durationController.text}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '$allCategories',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              ButtonTheme(
                                                  minWidth: 100,
                                                  height: 60,
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      DateTime now = DateTime.now();
                                                      int Hour = int.parse(DateFormat('HH').format(now));
                                                      int Min = int.parse(DateFormat('mm').format(now));
                                                      int Sec = int.parse(DateFormat('ss').format(now));

                                                      String projectDate = dateController.text;
                                                      String projectDay = projectDate.substring(0, 2);
                                                      String projectMonth = projectDate.substring(5, 7);
                                                      String projectYear = projectDate.substring(10, 14);

                                                      String projectTime = startTimeController.text;
                                                      String projectHour = projectTime.substring(0, 2);
                                                      String projectMins = projectTime.substring(3, 5);

                                                      DateTime projectDateTime = DateTime.parse(
                                                          "$projectYear-$projectMonth-$projectDay\T$projectHour:$projectMins");
                                                      Duration duration = projectDateTime.difference(now);
                                                      
                                                      await ScheduleNotification(duration.inSeconds);

                                                      int loc;
                                                      for (loc = 0;
                                                          loc <
                                                              projectData
                                                                  .length;
                                                          loc++) {
                                                        tmprealdate =
                                                            projectData[loc]
                                                                ["realdate"];
                                                        if (tmprealdate >
                                                            realdate) break;
                                                      }
                                                      projectData.insert(loc, {
                                                        "title": titleController
                                                            .text,
                                                        "date":
                                                            dateController.text,
                                                        "startTime":
                                                            startTimeController
                                                                .text,
                                                        "duration":
                                                            durationController
                                                                .text,
                                                        "description":
                                                            descriptionController
                                                                .text,
                                                        "realdate": realdate,
                                                        "categories": names,
                                                      });

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    color: Colors.blue,
                                                    child: Text(
                                                      'Okay',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: -60,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.greenAccent,
                                            radius: 50,
                                            child: Icon(
                                              Icons.assistant_photo,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          )),
                                    ],
                                  ));
                            },
                          );
                          for (int i = 0; i <= 4; i++) {
                            setState(() {
                              setState(() {
                                chose[i] = false;
                              });
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: LightColors.kBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage(
    this.payload, {
    Key key,
  }) : super(key: key);

  static const String routeName = '/secondPage';

  final String payload;

  @override
  State<StatefulWidget> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  String _payload;

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Second Screen with payload: ${_payload ?? ''}'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ),
      );
}
