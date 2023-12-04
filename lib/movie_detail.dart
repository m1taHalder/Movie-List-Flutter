import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MovieDetail extends StatelessWidget {
  final movie;
  var imageUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieDetail(this.movie, {super.key});

  Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.network(
          imageUrl + movie['poster_path'],
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(imageUrl + movie['poster_path']),
                          fit: BoxFit.cover),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: Offset(0.0, 10.0))
                      ]),
                  child: const SizedBox(
                    width: 400.0,
                    height: 400.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        movie['title'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'Arvo'),
                      )),
                      Text(
                        '${movie['vote_average']}/10',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Arvo'),
                      )
                    ],
                  ),
                ),
                Text(movie['overview'],
                    style: const TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                const Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      width: 150.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xaa3C3261)),
                      child: const Text(
                        'Rate Movie',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arvo',
                            fontSize: 20.0),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                          child: const Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
