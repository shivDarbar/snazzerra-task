import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/news.dart';

class NewsProvider with ChangeNotifier {
  final List<News> _newsList = [];
  List<News> get newsList {
    return [..._newsList];
  }

  TextEditingController searchController = TextEditingController();

  clearSearch() {
    searchController.clear();
    _newsList.clear();
    notifyListeners();
  }

  getNewsList() async {
    var searchText = searchController.text;
    _newsList.clear();
    var url =
        'https://newsapi.org/v2/everything?q=$searchText&from=2023-06-14&to=2023-06-10&sortBy=popularity&apiKey=5120a84a31aa49849beb506b9d60b325';
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);
    if (data['status'] == 'ok') {
      data['articles'].forEach(
        (news) {
          _newsList.add(
            News(
              title: news['title'],
              imageUrl: news['urlToImage'] ?? '',
              content: news['content'],
              author: news['author'] ?? '',
              date: news['publishedAt'],
            ),
          );
        },
      );
    }
    notifyListeners();
  }
}
