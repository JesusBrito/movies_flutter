import 'dart:async';
import 'dart:convert';
import 'package:movies_flutter/src/models/MActor.dart';
import 'package:movies_flutter/src/models/MMovie.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = "81318cd2c6ac57225543595167a23f9b";
  String _url = "api.themoviedb.org";
  String _language = "es-MX";
  int _page = 0;
  bool _loading = false;

  List<MMovie> _populars = new List();
  final _popularsStreamController = StreamController<List<MMovie>>.broadcast();

  Function(List<MMovie>) get popularesSink =>
      _popularsStreamController.sink.add;

  Stream<List<MMovie>> get popularesStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<MMovie>> _executeRequest(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final listMovies = new Movies.fromJson(decodedData['results']);
    return listMovies.items;
  }

  Future<List<MMovie>> getOnTheather() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {'api_key': _apiKey, 'language': _language});
    return await _executeRequest(url);
  }

  Future<List<MMovie>> getPopular() async {
    if (_loading) return [];

    _loading = true;

    _page++;

    final url = Uri.https(_url, "3/movie/popular",
        {'api_key': _apiKey, 'language': _language, 'page': _page.toString()});

    final response = await _executeRequest(url);
    _populars.addAll(response);
    popularesSink(_populars);

    _loading = false;

    return response;
  }

  Future<List<MActor>> getCast(String movieId) async {
    final url = Uri.https(_url, "3/movie/$movieId/credits", {
      'api_key': _apiKey,
      'language': _language,
    });
    final response = await http.get(url);
    final decodedResponse = json.decode(response.body);
    final actors = new Actors.fromJson(decodedResponse['cast']);
    return actors.cast;
  }

  Future<List<MMovie>> searchMovie(String query) async {
    final url = Uri.https(_url, "3/search/movie",
        {'api_key': _apiKey, 'language': _language, 'query': query});
    return await _executeRequest(url);
  }
}
