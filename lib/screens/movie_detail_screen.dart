import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/movie_detail_model.dart';
import 'package:youtube_netflix_clone/services/api_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiService apiService = ApiService();

  late Future<MovieDetailModel> movieDetailFuture;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetailFuture = apiService.getMovieDetail(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: movieDetailFuture,
            builder: (context, snapshot) {
              print(widget.movieId);
              if (snapshot.hasData) {
                final movie = snapshot.data;
                print('res $imageUrl${movie?.posterPath}');
                return Column(
                  children: [
                    Text(movie!.backdropPath),
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageUrl${movie.posterPath}"),
                                fit: BoxFit.cover),
                          ),
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
