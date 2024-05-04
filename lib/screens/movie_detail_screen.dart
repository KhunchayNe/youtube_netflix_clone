import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/movie_detail_model.dart';
import 'package:youtube_netflix_clone/models/movie_recommendation.dart';
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
  late Future<MovieRecommendationModel> movieRecommendation;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetailFuture = apiService.getMovieDetail(widget.movieId);
    movieRecommendation = apiService.getMovieRecommendation(widget.movieId);
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
              if (snapshot.hasData) {
                final movie = snapshot.data;

                String genreText = movie!.genres.map((e) => e.name).join(', ');

                return Column(
                  children: [
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(movie.releaseDate.year.toString(),
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              genreText,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                        future: movieRecommendation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final movie = snapshot.data;

                            return movie!.results.isEmpty
                                ? const SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'More like this',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GridView.builder(
                                          itemCount: movie.results.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 15,
                                                  crossAxisSpacing: 5,
                                                  childAspectRatio: 1.5 / 2),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieDetailScreen(
                                                                movieId: movie
                                                                    .results[
                                                                        index]
                                                                    .id)));
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$imageUrl${movie.results[index].posterPath}',
                                              ),
                                            );
                                          })
                                    ],
                                  );
                          } else {
                            return SizedBox.fromSize();
                          }
                        })
                  ],
                );
              } else {
                return const Text('Something went wrong');
              }
            }),
      ),
    );
  }
}
