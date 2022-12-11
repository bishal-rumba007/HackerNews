import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:hacker_news_proj/view/web_view_page.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/comment_provider.dart';
import '../provider/story_provider.dart';
import 'detail_page.dart';

class StoryPage extends ConsumerWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                    title: Text(data[index].title!,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                      data[index].by!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(getComments)
                                .fetchComment(kids: data[index].kids);
                            Get.to(() => DetailPage(news: data[index]));
                          },
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Get.to(
                                  () => WebViewApp(urlData: data[index].url!));
                            },
                            icon: const Icon(Icons.navigate_next)),
                      ),
                    ],
                );
              }, separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          },
          error: (err, stack) => Text('$err'),
          loading: () => Center(
            child: getShimmerLoading(),
          ),
        ),
      ),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 25,
                  width: 280,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 12,
                      width: 100,
                      color: Colors.white,
                    ),
                    Container(
                      height: 12,
                      width: 100,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
