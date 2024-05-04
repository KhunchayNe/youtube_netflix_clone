import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComingSoonMovieWidget extends StatelessWidget {
  const ComingSoonMovieWidget({
    super.key,
    required this.month,
    required this.day,
    required this.logoUrl,
    required this.imageUrl,
    required this.overview,
  });

  final String month;
  final String day;
  final String logoUrl;
  final String imageUrl;
  final String overview;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                month,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(day,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 5))
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(imageUrl: imageUrl),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      height: size.width * 0.2,
                      child: CachedNetworkImage(
                        imageUrl: logoUrl,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Remind Me',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 8),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 8),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coming on $month $day',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.5),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      overview,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 12.5),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
