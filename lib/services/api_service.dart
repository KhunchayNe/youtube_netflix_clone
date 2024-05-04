import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_netflix_clone/models/movie_detail_model.dart';
import 'package:youtube_netflix_clone/models/movie_model.dart';
import 'package:youtube_netflix_clone/models/movie_recommend_model.dart';
import 'package:youtube_netflix_clone/models/movie_recommendation.dart';
import 'package:youtube_netflix_clone/models/search_model.dart';
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

  Future<MovieModel> getNowPlayingMovies() async {
    endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success getNowPlayingMovies');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<TvSeries> getTvSeries() async {
    endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success getTvSeries');
      return TvSeries.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load tv series movies');
  }

  Future<SearchMovies> getSearchedMovie(String searchText) async {
    endPoint = 'search/movie?query=';
    final url = '$baseUrl$endPoint$searchText';
    Map<String, String> header = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjY1ODczYzQ1ZDdlNjc3ZGVmNTUzZDI5YTI2MDkxOCIsInN1YiI6IjY2MzI0ZTgyZDE4NTcyMDEyNTMzZDFjNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eksGUyxcWYO4AfNawJ2dm33DYiwV_4DciHhWQYHgmnw',
    };
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      log('success getSearchedMovie');
      return SearchMovies.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load search movies');
  }

  Future<MovieRecommendModel> getMovieRecommend() async {
    endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint';
    Map<String, String> header = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjY1ODczYzQ1ZDdlNjc3ZGVmNTUzZDI5YTI2MDkxOCIsInN1YiI6IjY2MzI0ZTgyZDE4NTcyMDEyNTMzZDFjNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eksGUyxcWYO4AfNawJ2dm33DYiwV_4DciHhWQYHgmnw',
    };
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      log('success getMovieRecommend');
      return MovieRecommendModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movies recommend');
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint';
    Map<String, String> header = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjY1ODczYzQ1ZDdlNjc3ZGVmNTUzZDI5YTI2MDkxOCIsInN1YiI6IjY2MzI0ZTgyZDE4NTcyMDEyNTMzZDFjNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eksGUyxcWYO4AfNawJ2dm33DYiwV_4DciHhWQYHgmnw',
    };
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      log('success getMovieDetail');
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movie details');
  }

  Future<MovieRecommendationModel> getMovieRecommendation(int movieId) async {
    try {
      endPoint = 'movie/$movieId/recommendations';
      final url = '$baseUrl$endPoint';
      Map<String, String> header = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjY1ODczYzQ1ZDdlNjc3ZGVmNTUzZDI5YTI2MDkxOCIsInN1YiI6IjY2MzI0ZTgyZDE4NTcyMDEyNTMzZDFjNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eksGUyxcWYO4AfNawJ2dm33DYiwV_4DciHhWQYHgmnw',
      };
      // final response = await http.get(Uri.parse(url), headers: header);
      final response = await dio.get(url, options: Options(headers: header));
      if (response.statusCode == 200) {
        print('Res : ${response.toString()}');
        print(movieId);
        log('success getMovieRecommendation');
        return MovieRecommendationModel.fromJson(response.data);
      }
      throw Exception('failed to load movie details');
    } catch (e) {
      print(e.toString());
      throw Exception('failed to load movie details');
    }
  }
}
