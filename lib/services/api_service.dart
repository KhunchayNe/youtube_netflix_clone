import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';
late String endPoint;

class ApiService {
  final dio = Dio();

  Future<UpcomingMovie> getUpcomingMovies() async {
    endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';
    // Map<String, dynamic> header = {'Authorization': 'Bearer $token'};
    final resp = await http.get(Uri.parse(url));
    // final resp = await dio.get(url, options: Options(headers: header));
    if (resp.statusCode == 200) {
      log('Success');
      return UpcomingMovie.fromJson(jsonDecode(resp.body));
    }
    throw Exception("Failed to load upcoming movies");
    // try {
    //   print('Success1');
    //   endPoint = 'movie/upcoming';
    //   final url = '$baseUrl$endPoint';
    //   Map<String, dynamic> header = {'Authorization': 'Bearer $token'};
    //   // final resp = await http.get(Uri.parse(url));
    //   final resp = await dio.get(url, options: Options(headers: header));
    //   print('Success2');
    //   if (resp.statusCode == 200) {
    //     // log('Success');
    //     print('Success');
    //     return UpcomingMovie.fromJson(jsonDecode(resp.data));
    //   } else {
    //     print('Error');
    //     throw Exception("Failed to load upcoming movies");
    //   }
    // } catch (e) {
    //   print("Failed to load upcoming movies : ${e.toString()}");
    //   throw Exception("Failed to load upcoming movies");
    // }
  }
}
