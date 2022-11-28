import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/topStory.dart';
import '../provider/comment_provider.dart';


class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.news});
  final News news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment"),
        actions: [
          const Icon(Icons.search),
          const SizedBox(
            width: 6,
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.refresh(commentProvider);
                },
                icon: const Icon(Icons.refresh),
              );
            },
          ),
          const SizedBox(
            width: 6,
          ),
          const Icon(Icons.bookmark_add_outlined),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(news.title!),
              subtitle: Text(news.url!),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Comment Section",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Consumer(
              builder: (context, ref, child) {
                final comment = ref.watch(commentProvider);
                return ListView.builder(
                  itemCount: comment.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.person),
                      ),
                      title: Text(comment[index].by == null
                          ? "Unknown User"
                          : comment[index].by!),
                      subtitle: Text(comment[index].text == null
                          ? "Nothing"
                          : comment[index].text!),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}