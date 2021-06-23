import 'package:flutter/material.dart';
import 'page/login_screen.dart';
import 'page/consts/light_colors.dart';
import 'package:flutter/services.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Root
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme
            .of(context)
            .textTheme
            .apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'
        ),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}