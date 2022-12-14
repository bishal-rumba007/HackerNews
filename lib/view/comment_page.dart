import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news_proj/view/custom_shimmer.dart';
import 'package:hacker_news_proj/view/web_view_page.dart';
import 'package:shimmer/shimmer.dart';

import '../model/news.dart';
import '../provider/comment_provider.dart';

class CommentPage extends ConsumerWidget {
  const CommentPage({Key? key, required this.news}) : super(key: key);
  final News news;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff457B9D),
        body: ListView(
          children: [
            SizedBox(
              height: 0.34 * height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.01,
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
                        SizedBox(
                          height: height * 0.01,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => WebViewApp(urlData: news.url!),);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.green[400]!,
                            minimumSize: Size(double.infinity, height * 0.065),
                          ),
                          child: const Text(
                            'View Full News',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Comments:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: height * 0.90,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: ListView(
                children: news.kids!.map((e) {
                  final commentData = ref.watch(commentsProvider(e));
                  return commentData.when(
                      data: (data){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.by}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 2,),
                              ExpandableText('${data.text}',
                                expandText: 'Read more',
                                collapseText: 'Read less',
                                maxLines: 5,
                                linkColor: Colors.blueGrey[200],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                      error: (err, stack) => Text(err.toString()),
                      loading: () => shimmerLoad(),
                  );

                }).toList(),

              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget shimmerLoad(){
    return Shimmer.fromColors(
        baseColor:Colors.grey.shade400,
        highlightColor:Colors.grey.shade500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 15,
                width: 90,
                color: Colors.white,
              ),
              const SizedBox(height: 5,),
              Container(
                height: 25,
                width: double.infinity,
                color: Colors.white,
              ),
            ],
          ),
        )
    );
  }
}
