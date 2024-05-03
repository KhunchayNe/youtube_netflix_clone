import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/upcoming_model.dart';
import 'package:youtube_netflix_clone/services/api_service.dart';
import 'package:youtube_netflix_clone/widgets/movie_card.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovie> upcomingFuture;
  ApiService apiService = ApiService();
  @override
  void initState() {
    upcomingFuture = apiService.getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroudColor,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 27,
              width: 27,
            ),
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: MovieCard(
                  future: upcomingFuture, headLineText: "Upcoming Movies"),
            )
          ],
        ),
      ),
    );
  }
}
