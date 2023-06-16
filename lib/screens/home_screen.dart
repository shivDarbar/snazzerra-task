import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snazzerra_task/providers/news_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: newsProvider.searchController,
              onChanged: (value) {
                newsProvider.getNewsList();
              },
              onSubmitted: (value) {
                newsProvider.getNewsList();
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    newsProvider.clearSearch();
                  },
                ),
                hintText: 'Search News',
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
              ),
            ),
          ),
          if (newsProvider.newsList.isNotEmpty)
            Flexible(
              fit: FlexFit.loose,
              child: Consumer<NewsProvider>(builder: (context, news, child) {
                var newsList = news.newsList;
                return ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(4, 0),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.white,
                        onTap: () {},
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            height: mediaQuery.size.shortestSide * 0.15,
                            width: mediaQuery.size.shortestSide * 0.12,
                            child: CachedNetworkImage(
                              imageUrl: newsList[index].imageUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        isThreeLine: true,
                        title: Text(
                          newsList[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          newsList[index].content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          if (newsProvider.newsList.isEmpty)
            Column(
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.35,
                ),
                Center(
                  child: Text(
                    'Search News.',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
