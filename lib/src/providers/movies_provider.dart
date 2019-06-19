import 'dart:convert';

import 'package:movies_flutter/src/models/MMovie.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = "81318cd2c6ac57225543595167a23f9b";
  String _url = "api.themoviedb.org";
  String _language = "es-MX";

  Future<List<MMovie>> getOnTheather() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {'api_key': _apiKey, 'language': _language});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final listMovies = new Movies.fromJson(decodedData['results']);
    return listMovies.items;
  }
}
