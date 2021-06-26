import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

AudioPlayer audioPlayer = AudioPlayer();

String currentPlayingImage =
    'https://media.istockphoto.com/photos/rain-fall-on-the-ground-picture-id1049365996?k=6&m=1049365996&s=612x612&w=0&h=B9SVdcbia5IAMRcF4kKsWohdTH3KV6DpObevzRdDg_w=';

final List<String> _listItem = [
  'https://www.energids.be/nl/media/mediumimg/18/24tarif-exclusif-nuit.jpg',
  'https://learnenglishteens.britishcouncil.org/sites/teens/files/styles/article/public/field/image/rs930_135120665-low.jpg?itok=g5LI5W4C',
  'https://media.istockphoto.com/photos/rain-fall-on-the-ground-picture-id1049365996?k=6&m=1049365996&s=612x612&w=0&h=B9SVdcbia5IAMRcF4kKsWohdTH3KV6DpObevzRdDg_w=',
  'http://images6.fanpop.com/image/photos/40700000/Pretty-Bird-birds-40741715-800-600.jpg',
  'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2020%2F11%2F18%2Fcampfire-2000.jpg&q=85',
  'https://images.unsplash.com/photo-1456356627738-3a96db6e2e33?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YnJlZXplfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
];
final List<String> _listSound = [
  'https://learnsup.000webhostapp.com/night.wav',
  'https://learnsup.000webhostapp.com/forest.mp3',
  'https://learnsup.000webhostapp.com/rain.mp3',
  'https://learnsup.000webhostapp.com/bird.wav',
  'https://learnsup.000webhostapp.com/campfire.mp3',
  'https://learnsup.000webhostapp.com/wind.wav',
];

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(currentPlayingImage),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Currently playing",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          var random = Random().nextInt(6);
                          audioPlayer.stop();
                          audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                          audioPlayer.play(_listSound[random]);
                          setState(() {
                            currentPlayingImage = _listItem[random];
                          });
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                              child: Text(
                            "Random",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _listItem
                    .map((item) => Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            var index = _listItem.indexOf(item);
                            audioPlayer.stop();
                            audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                            audioPlayer.play(_listSound[index]);
                            setState(() {
                              currentPlayingImage = item;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.cover)),
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Icon(
                                  Icons.bookmark_border,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        )))
                    .toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
