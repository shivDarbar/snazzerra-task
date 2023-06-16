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
      appBar: AppBar(title: const Text('Welcome')),
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
                    newsProvider.searchController.clear();
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
          Flexible(
            fit: FlexFit.loose,
            child: Consumer<NewsProvider>(builder: (context, news, child) {
              var newsList = news.newsList;
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          height: mediaQuery.size.shortestSide * 0.14,
                          width: mediaQuery.size.shortestSide * 0.12,
                          child: Image.network(
                            newsList[index].imageUrl,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
