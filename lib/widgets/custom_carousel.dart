import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_netflix_clone/common/utils.dart';
import 'package:youtube_netflix_clone/models/tv_series_model.dart';

class CustomCaruel extends StatelessWidget {
  final TvSeries data;
  const CustomCaruel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.35 < 300) ? 200 : size.height * 0.35,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index, realIndex) {
            var url = data.results[index].backdropPath.toString();

            return GestureDetector(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: '$imageUrl$url',
                  ),
                  Text(data.results[index].title)
                ],
              ),
            );
          },
          options: CarouselOptions(
              height: (size.height * 0.35 < 300) ? 300 : size.height * 0.35,
              aspectRatio: 16 / 9,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal)),
    );
  }
}
