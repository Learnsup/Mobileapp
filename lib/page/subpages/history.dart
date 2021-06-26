import 'package:flutter/material.dart';

class CurvedRectangleClipper extends CustomClipper<Path> {
  final double offset = 80;

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height - offset);
    var firstEndpoint = Offset(offset, size.height);
    path.arcToPoint(firstEndpoint,
        radius: Radius.circular(-offset), clockwise: false);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, offset);
    path.lineTo(offset, offset);

    var secondEndPoint = Offset(0, 0);

    path.arcToPoint(secondEndPoint,
        radius: Radius.circular(-offset), clockwise: true);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    this.title,
    this.time,
    this.icon,
    this.people,
    this.color,
    this.nextColor,
    this.description,
  });

  final String title;
  final String description;
  final String time;
  final String people;
  final IconData icon;
  final Color color;
  final Color nextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 32,
          top: 40.0,
          bottom: 40,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                time,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                description,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
              ),
              Row(),
            ]),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History', style: TextStyle(fontSize: 20),),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CurvedListItem(
            title: '-  100% Tasks done \n-  100% Efficiency',
            time: '25 / 6 / 2021',
            description: "Done tasks : Draw , sleep, design web app",
            color: Colors.greenAccent,
            nextColor: Colors.blueAccent,
          ),
          CurvedListItem(
            title: '-  75% Tasks done \n-  65% Efficiency',
            time: '24 / 6 / 2021',
            description: "Done tasks : Draw , study\nSkipped : Develop mobile app",
            color: Colors.blueAccent,
            nextColor: Colors.orangeAccent,
          ),
          CurvedListItem(
            title: '-  100% Tasks done \n-  100% Efficiency',
            time: '23 / 6 / 2021',
            description: "Done tasks : Draw , sleep, design web app",
            color: Colors.orangeAccent,
            nextColor: Colors.greenAccent,
          ),
          CurvedListItem(
            title: '-  50% Tasks done \n-  55% Efficiency',
            time: '22 / 6 / 2021',
            description: "Done tasks : Sleep, design web\nSkipped : Read books, develop web app",
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
