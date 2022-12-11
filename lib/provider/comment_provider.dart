import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/comments.dart';

final getComments = Provider((ref) => CommentProvider());
final commentProvider = Provider.autoDispose((ref) => listOfComments);

List<Comments> listOfComments = [];

class CommentProvider {
  Future<void> fetchComment({List? kids}) async {
    final dio = Dio();
    try {
      if (kids != null) {
        for (int i = 0; i < kids.length; i++) {
          int id = await kids[i];

          final news = await dio
              .get("https://hacker-news.firebaseio.com/v0/item/$id.json");
          Map<String, dynamic> map = await news.data;
          final data = Comments.fromJson(map);
          listOfComments.add(data);
        }
      }
    } on DioError catch (err) {
      throw err.message;
    }
  }
}
