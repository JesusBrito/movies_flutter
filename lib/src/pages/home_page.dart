import 'package:flutter/material.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';
import 'package:movies_flutter/src/search/search_delegate.dart';
import 'package:movies_flutter/src/widgets/card_swiper_widget.dart';
import 'package:movies_flutter/src/widgets/movies_horizontal.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider _moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopular();

    return Scaffold(
        appBar: AppBar(
          title: Text("Movies on Theather"),
          backgroundColor: Colors.indigoAccent,
          centerTitle: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperCards(), _footer(context)],
        )));
  }

  Widget _swiperCards() {
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

  Widget _footer(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Populares', style: Theme.of(context).textTheme.subhead),
        SizedBox(height: 10.0),
        StreamBuilder(
            stream: _moviesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return MovieHorizontal(
                    movies: snapshot.data,
                    nextPage: _moviesProvider.getPopular);
              else
                return CircularProgressIndicator();
            }),
      ],
    );
  }
}
