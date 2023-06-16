import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({super.key, required this.news});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            buildHeaderImage(mediaQuery),
            buildNewsText(mediaQuery),
          ],
        ),
      ),
    );
  }

  Container buildNewsText(MediaQueryData mediaQuery) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * 0.05,
        vertical: mediaQuery.size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              news.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            news.content,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Author: ${news.author}',
          ),
          Text(
            news.date,
          ),
        ],
      ),
    );
  }

  SizedBox buildHeaderImage(MediaQueryData mediaQuery) {
    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.4,
      child: CachedNetworkImage(
        imageUrl: news.imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
