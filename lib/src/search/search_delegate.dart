import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_flutter/src/models/MMovie.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  MMovie movieSelected;
  final moviesProvider = new MoviesProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del AppBar
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono inicial
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados para mostrar
    // TODO: implement buildResults
    return Center(
        child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.indigoAccent,
            child: Text(movieSelected.title)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Crea las sugerencias que se van a mostrar
    // TODO: implement buildSuggestions

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<MMovie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
              children: movies.map((movie) {
            movie.uniqueID = '${movie.id}-search';
            return ListTile(
              leading: Hero(
                  tag: movie.uniqueID,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage(
                      image: NetworkImage(movie.getPosterImg()),
                      placeholder:
                          AssetImage('assets/img/image-placeholder.png'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                  )),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'detail', arguments: movie);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /*
    final filteredList = (query.isEmpty)
        ? moviesRecent
        : moviesRecent
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, i) {
        ListTile(
          leading: Icon(Icons.movie),
          title: Text(filteredList[i]),
          onTap: (){
            movieSelected = filteredList[i];
            showResults(context);
          },
        );
      },
    );
  */
}
