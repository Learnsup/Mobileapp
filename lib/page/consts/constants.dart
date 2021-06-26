import 'package:flutter/material.dart';

var projectData = [
  {
    "title": "Learn",
    "date": "28 / 06 / 2021",
    "startTime": "14:00",
    "duration": "120p",
    "description": "Nope",
    "realdate": 8 * 24 * 3600 + 14 * 3600,
    "categories": null,
  },
  {
    "title": "Do homework",
    "date": "28 / 06 / 2021",
    "startTime": "16:00",
    "duration": "60p",
    "description": "Help",
    "realdate": 8 * 24 * 3600 + 16 * 3600,
    "categories": null,
  },
  {
    "title": "Draw",
    "date": "28 / 06 / 2021",
    "startTime": "18:00",
    "duration" : "60p",
    "description": "Waifu",
    "realdate" : 8 * 24 * 3600 + 18 * 3600,
    "categories": null,
  },
  {
    "title": "Design",
    "date": "28 / 06 / 2021",
    "startTime": "20:00",
    "duration": "90p",
    "description": "Web app",
    "realdate": 8 * 24 * 3600 + 20 * 3600,
    "categories": null,
  },
  {
    "title": "Learn",
    "date": "29 / 06 / 2021",
    "startTime": "7:30",
    "duration": "120p",
    "description": "Nope nope",
    "realdate": (9 * 24 + 7) * 3600 + 30 * 60,
    "categories": null,
  },
  {
    "title": "Reading books",
    "date": "29 / 06 / 2021",
    "startTime": "15:00",
    "duration": "30p",
    "description": "Heh",
    "realdate": (9 * 24 + 15) * 3600,
    "categories": null,
  },
  {
    "title": "Design",
    "date": "28 / 06 / 2021",
    "startTime": "21:00",
    "duration": "45p",
    "description": "Mobile /  PC apps",
    "realdate": (9 * 24 + 21) * 3600,
    "categories": null,
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
