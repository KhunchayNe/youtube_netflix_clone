import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/movie_recommend_model.dart';
import 'package:youtube_netflix_clone/screens/movie_detail_screen.dart';

class MovieRecommend extends StatelessWidget {
  final Future<MovieRecommendModel> future;
  final String headLineText;
  const MovieRecommend(
      {super.key, required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.results;
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      headLineText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  itemCount: data?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                      movieId: data[index].id,
                                    )));
                      },
                      child: Container(
                        height: 150,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                                '$imageUrl${data?[index].posterPath}'),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 260,
                              child: Text(
                                data![index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
