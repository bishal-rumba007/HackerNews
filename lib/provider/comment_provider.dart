import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news_proj/model/comments.dart';

final commentsProvider = FutureProvider.family((ref, int id) => getComment(id));

Future<CommentModel> getComment (int id) async{

  try{
    final dio = Dio();

    final response = await dio.get("https://hacker-news.firebaseio.com/v0/item/$id.json");
    final data = response.data;
    final newsData = CommentModel.fromJson(data);
    return newsData;

  } on DioError catch(err){
    throw err.message;
  }

}