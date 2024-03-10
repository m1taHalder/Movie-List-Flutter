import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  MovieListState createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var movies;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: mainColor,
        ),
        title: Text(
          'Movies',
          style: TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Icon(
            Icons.menu,
            color: mainColor,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieTitle(mainColor),
            Expanded(
              child: ListView.builder(
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return TextButton(
                      child: MovieCell(movies, i),
                      // padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MovieDetail(movies[i]);
                        }));
                      },
                      //color: Colors.white,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future getJson() async {
  //var apiKey = "3354c6563712f6717437182b5fa0e039";
  // 'http://api.themoviedb.org/3/discover/movie?api_key=3354c6563712f6717437182b5fa0e039';
  var url = Uri.parse(
      'http://api.themoviedb.org/3/discover/movie?api_key=3354c6563712f6717437182b5fa0e039');
  http.Response response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
  //var response = await http.get(url);
  // return json.decode(response.body);
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;

  const MovieTitle(this.mainColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Text(
        'Top Rated',
        style: TextStyle(
            fontSize: 18.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCell extends StatelessWidget {
  final movies;
  final i;
  Color mainColor = const Color(0xff3C3261);
  var imageUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieCell(this.movies, this.i, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(imageUrl + movies[i]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: const Offset(2.0, 5.0))
                  ],
                ),
//                                child:  Image.network(imageUrl+movies[i]['poster_path'],width: 100.0,height: 100.0),
                child: const SizedBox(
                  width: 70.0,
                  height: 70.0,
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movies[i]['title'],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  const Padding(padding: EdgeInsets.all(2.0)),
                  Text(
                    movies[i]['overview'],
                    maxLines: 3,
                    style: const TextStyle(
                        color: Color(0xff8785A4), fontFamily: 'Arvo'),
                  )
                ],
              ),
            )),
          ],
        ),
        Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}
