import 'package:flutter/material.dart';
import 'package:movies_flutter/src/models/MMovie.dart';
import 'package:movies_flutter/src/models/MActor.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MMovie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        _createAppBar(movie, context),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitle(movie, context),
            _description(movie),
            _casting(movie)
          ]),
        )
      ]),
    );
  }

  Widget _createAppBar(MMovie movie, BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0,),
          overflow: TextOverflow.clip
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/image-placeholder.png'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget _description(MMovie movie) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ));
}

Widget _casting(MMovie movie) {
  final movieProvider = new MoviesProvider();

  return FutureBuilder(
    future: movieProvider.getCast(movie.id.toString()),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return _createActorsPageView(snapshot.data);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget _createActorsPageView(List<MActor> actors) {
  return SizedBox(
    height: 200,
    child: PageView.builder(
      pageSnapping: false,
      controller: PageController(initialPage: 1, viewportFraction: 0.3),
      itemCount: actors.length,
      itemBuilder: (context, i) {
        return _actorCard(actors[i]);
      },
    ),
  );
}

Widget _actorCard(MActor actor) {
  return Container(
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(actor.getProfileImg()),
            placeholder: AssetImage('assets/img/image-placeholder.png'),
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Text(actor.name, overflow: TextOverflow.clip)
      ],
    ),
  );
}

Widget _posterTitle(MMovie movie, BuildContext context) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(movie.title,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.clip),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.clip),
                Row(children: <Widget>[
                  Icon(Icons.star_border),
                  Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead)
                ])
              ],
            ),
          )
        ],
      ));
}
