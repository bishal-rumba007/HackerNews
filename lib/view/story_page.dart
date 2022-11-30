import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news_proj/view/web_view_page.dart';

import '../provider/comment_provider.dart';
import '../provider/story_provider.dart';
import 'detail_page.dart';

class StoryPage extends ConsumerWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final storyData = ref.watch(topStoryProvider);
    final storyData = ref.watch(topStoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Stories'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // ignore: unused_result
                ref.refresh(topStoryProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
          child: storyData.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.black12,
                      ))),
                      child: ExpansionTile(
                        title: Text(
                          data[index].title!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          data[index].by!,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(commentCall)
                                    .getComment(kids: data[index].kids);
                                Get.to(() => DetailPage(news: data[index]));
                              },
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'id: ${data[index].id!}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          'score: ${data[index].score!.toString()}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.message_outlined,
                                          color: Colors.black54,
                                        ),
                                        // IconButton(
                                        //     onPressed: (){
                                        //       ref.read(commentCall).getComment(kids: data[index].kids);
                                        //       Get.to(() => DetailPage(news: data[index]));
                                        //     },
                                        //     icon: const Icon(Icons.message_outlined, color: Colors.black54,)
                                        // ),

                                        Text(
                                          data[index].descendants.toString(),
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(data[index].url.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  Get.to(() =>
                                      WebViewApp(urlData: data[index].url!));
                                },
                                icon: const Icon(Icons.navigate_next)),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => const Center(child: CircularProgressIndicator()))),
    );
  }
}
