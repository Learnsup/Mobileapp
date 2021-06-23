import 'package:flutter/material.dart';

const FOOD_DATA = [
  {
    "name": "Học tập",
    "brand": "Anh, Toán, Sử, Địa, Bủh",
    "price": "14:00 - trong 2h",
  },
  {
    "name": "Làm BTVN",
    "brand": "Đắc đắc",
    "price": "16:00 - trong 1h",
  },
  {"name": "Vẽ", "brand": "Mcdonald", "price": 2.99},
  {
    "name": "Thiết kế",
    "brand": "Web app",
    "price": "20:00 - trong 1h30p",
  },
  {
    "name": "Học tập",
    "brand": "Sinh, Hóa, Văn, Lý, Bủh",
    "price": "7:30 ngày mai - trong 2h",
  },
  {
    "name": "Đọc sách",
    "brand": "Pỏn",
    "price": "15:00 ngày mai - trong 30p",
  },
  {
    "name": "Thiết kế",
    "brand": "Mobile /  PC apps",
    "price": "21:00 ngày mai - trong 45p",
  },
];

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
