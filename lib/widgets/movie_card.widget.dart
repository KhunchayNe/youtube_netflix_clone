import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Future<MovieModel> future;
  final String headLineText;
  const MovieCard(
      {super.key, required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
       if (snapshot.hasData) {
            var data = snapshot.data?.results;
        return Column(
          children: [
            Text(
              headLineText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: data?.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network('$imageUrl${data?[index].posterPath}'),
                  );
                },
              ),
            )
          ],
        );
       } else {
            return const SizedBox.shrink();
          }
      },
    );
  }
}
