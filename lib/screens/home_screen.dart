import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/movie_model.dart';
import 'package:youtube_netflix_clone/models/tv_series_model.dart';
import 'package:youtube_netflix_clone/services/api_service.dart';
import 'package:youtube_netflix_clone/widgets/custom_carousel.dart';
import 'package:youtube_netflix_clone/widgets/movie_card.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MovieModel> upcomingFuture;
  late Future<MovieModel> nowPlayingFuture;
  late Future<TvSeries> tvSeriesFuture;
  ApiService apiService = ApiService();
  @override
  void initState() {
    upcomingFuture = apiService.getUpcomingMovies();
    nowPlayingFuture = apiService.getNowPlayingMovies();
    tvSeriesFuture = apiService.getTvSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgoundColor,
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
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: tvSeriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomCaruel(data: snapshot.data!);
                  }
                  return const SizedBox.square();
                }),
            SizedBox(
              height: 220,
              child: MovieCard(
                future: nowPlayingFuture,
                headLineText: 'Now Playing',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: MovieCard(
                future: upcomingFuture,
                headLineText: 'Upcoming Movies',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
