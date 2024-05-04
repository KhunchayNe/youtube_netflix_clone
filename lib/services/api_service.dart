import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_netflix_clone/models/movie_model.dart';


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
      log('success');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }
}
