import 'package:flutter/material.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';
import 'package:movies_flutter/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider _moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movies on Theather"),
          backgroundColor: Colors.indigoAccent,
          centerTitle: false,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[_swiperCards()],
        )));
  }

  _swiperCards() {
    return FutureBuilder(
        future: _moviesProvider.getOnTheather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return CardSwiper(movies: snapshot.data);
          else
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }
}
