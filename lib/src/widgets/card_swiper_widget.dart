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
            return ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    placeholder:

                    image: NetworkImage(
                        movies[index].getPosterImg()
                    )
                ));
          },
          itemCount: movies.length,
          //agination: new SwiperPagination(),
          //control: new SwiperControl(),
        ));
  }
}
