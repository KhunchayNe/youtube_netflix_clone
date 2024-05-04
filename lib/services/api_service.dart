import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_netflix_clone/models/movie_model.dart';
import 'package:youtube_netflix_clone/models/tv_series_model.dart';


const baseUrl = 'https://api.themoviedb.org/3/';
var key = '?api_key=$apiKey';
late String endPoint;

class ApiService {
  final dio = Dio();

  Future<MovieModel> getUpcomingMovies() async {
    endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success getUpcomingMovies');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<MovieModel> getNowPlayingMovies() async{
    endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success getNowPlayingMovies');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<TvSeries> getTvSeries()async {
    endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success getTvSeries');
      return TvSeries.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load tv series movies');
  }
}
