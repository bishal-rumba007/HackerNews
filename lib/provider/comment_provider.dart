import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/comments.dart';


final commentCall = Provider((ref) => CommentProvider());
final commentProvider = Provider.autoDispose((ref) => commentList);

List<Comments> commentList = [];
// Map<Comments, dyanmic> commentData = [];

class CommentProvider {
  Future<void> getComment({List? kids}) async {
    try {
      final dio = Dio();

      if (kids != null) {
        for (int i = 0; i < kids.length; i++) {
          int id = await kids[i];

          final news = await dio.get("https://hacker-news.firebaseio.com/v0/item/$id.json");
          Map<String, dynamic> map = await news.data;
          final data = Comments.fromJson(map);
          commentList.add(data);
        }
      }
    } on DioError catch(err) {
      throw err.message;
    }
  }
}