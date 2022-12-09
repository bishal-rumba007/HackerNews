import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news_proj/view/web_view_page.dart';
import '../model/topStory.dart';
import '../provider/comment_provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: height * 0.30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return IconButton(
                            onPressed: () {
                              ref.refresh(commentProvider);
                            },
                            icon: const Icon(
                              Icons.replay,
                              color: Colors.white,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(news.title!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Author - ${news.by}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                'id: ${news.id!}',
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(() => WebViewApp(urlData: news.url!));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text('Go to Web'),
                                    const Icon(Icons.web)
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
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
                            ? "User unknown"
                            : comment[index].by!),
                        subtitle: Text(comment[index].text == null
                            ? "No comments"
                            : comment[index].text!),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
