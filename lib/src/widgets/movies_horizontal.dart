import 'package:flutter/material.dart';
import 'package:movies_flutter/src/models/MMovie.dart';

class MovieHorizontal extends StatelessWidget {
  final List<MMovie> movies;

  const MovieHorizontal({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
          ),
        children: _tarjetas(context)
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context){
    return movies.map((movie){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius:  BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/image-placeholder.png'),
                fit: BoxFit.cover, 
                height: 160.0,          
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,    
            )
          ],
        )
      );
    }).toList();
  }
}