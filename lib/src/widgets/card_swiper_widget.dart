import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_flutter/src/models/MMovie.dart';

class CardSwiper extends StatelessWidget {
  final List<MMovie> movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screensize.width * 0.7,
          itemHeight: _screensize.height * 0.5,
          itemBuilder: (BuildContext context, int index) {
            return _card(movies[index], context);
          },
          itemCount: movies.length,
          //agination: new SwiperPagination(),
          //control: new SwiperControl(),
        ));
  }

  Widget _card(MMovie movie, context) {
    movie.uniqueID = '${movie.id}-tarjeta';
    final movieCard = Hero(
      tag: movie.uniqueID,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/image-placeholder.png'),
              fit: BoxFit.cover,
              image: NetworkImage(movie.getPosterImg()))),
    );

    return GestureDetector(
      child: movieCard,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }
}
