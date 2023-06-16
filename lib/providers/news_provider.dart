import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/news.dart';

class NewsProvider with ChangeNotifier {
  final List<News> _newsList = [];
  List<News> get newsList {
    return [..._newsList];
  }

  bool errorOccured = false;
  bool isLoading = false;

  String errorText = '';

  TextEditingController searchController = TextEditingController();

  clearSearch() {
    searchController.clear();
    _newsList.clear();
    notifyListeners();
  }

  toggleIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Timer? typingStopTimer;

  onChangeHandler() {
    const duration = Duration(
      seconds: 1,
    );
    if (typingStopTimer != null) {
      typingStopTimer!.cancel();
      notifyListeners();
    }
    typingStopTimer = Timer(duration, () => getNewsList());
    notifyListeners();
  }

  getNewsList() async {
    var searchText = searchController.text;
    errorOccured = false;
    toggleIsLoading(true);
    _newsList.clear();
    var url =
        'https://newsapi.org/v2/everything?q=$searchText&from=2023-06-01&to=2023-06-15&sortBy=popularity&apiKey=b9efa241606e446987657ac601e6b6bc';
    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      if (data['status'] == 'ok') {
        data['articles'].forEach(
          (news) {
            _newsList.add(
              News(
                title: news['title'],
                imageUrl: news['urlToImage'] ?? '',
                content: news['description'],
                author: news['author'] ?? '',
                date: news['publishedAt'],
              ),
            );
          },
        );
      } else if (response.statusCode == 429) {
        errorOccured = true;
        errorText = 'API limit reached.Try after 24 hours.';
      }
      toggleIsLoading(false);
    } catch (error) {
      print(error);
      errorOccured = true;
      errorText = 'Something went wrong.\nPlease try again.';
      toggleIsLoading(false);
    }
    notifyListeners();
  }
}
