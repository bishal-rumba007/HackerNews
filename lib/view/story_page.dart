import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news_proj/view/custom_shimmer.dart';
import '../provider/story_provider.dart';
import 'comment_page.dart';


class StoryPage extends ConsumerWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyData = ref.watch(topStoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff457B9D),
        centerTitle: true,
        elevation: 0,
        title: const Text('Top Stories'),
      ),
      body: SafeArea(
        child: storyData.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  color: const Color(0xffF1FAEE),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                    title: Text(data[index].title!,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                      'Author - ${data[index].by!}',
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => CommentPage(news: data[index]));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'score: ${data[index].score!.toString()}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.message,
                                    color: Colors.black54,
                                  ),
                                  Text('${data[index].kids?.length}',
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          error: (err, stack) => Text('$err'),
          loading: () => const ShimmerLoading(),
        ),
      ),
    );
  }
}
