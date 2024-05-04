import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/movie_recommend_model.dart';
import 'package:youtube_netflix_clone/models/search_model.dart';
import 'package:youtube_netflix_clone/services/api_service.dart';
import 'package:youtube_netflix_clone/widgets/movie_recommend.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  SearchMovies? searchMovie;
  late Future<MovieRecommendModel> popularMovies;

  ApiService apiService = ApiService();

  void search(String query) {
    apiService.getSearchedMovie(query).then((value) => {
          setState(() {
            searchMovie = value;
          })
        });
  }

  @override
  void initState() {
    popularMovies = apiService.getMovieRecommend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                CupertinoSearchTextField(
                  padding: const EdgeInsets.all(10.0),
                  controller: searchController,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      searchController.clearComposing();
                      setState(() {
                        popularMovies = apiService.getMovieRecommend();
                      });
                    } else {
                      search(searchController.text);
                    }
                  },
                ),
                searchController.text.isEmpty
                    ? MovieRecommend(
                        future: popularMovies,
                        headLineText: 'Top Searches',
                      )
                    : searchMovie == null
                        ? const SizedBox.shrink()
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: searchMovie?.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1.2 / 2),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  searchMovie?.results[index].backdropPath ==
                                          null
                                      ? Image.asset(
                                          "assets/netflix.png",
                                          height: 170,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              '$imageUrl${searchMovie?.results[index].backdropPath}',
                                          height: 170,
                                        ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      searchMovie!.results[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              );
                            })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
