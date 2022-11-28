import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api.dart';
import '../model/topStory.dart';



final topStoryProvider = FutureProvider<List<News>>((ref) => StoryProvider().getTopStories());

class StoryProvider{
  late List ids = [];
  List<News> newsList = [];


  Future<List<News>> getTopStories() async{
    final dio = Dio();
    try{
      final response = await dio.get(Api.topStories);
      if(response.statusCode == 200){
        ids = response.data;

        for(int i = 0; i < 20; i++){
          int id = ids[i];

          final responseNews = await dio.get('https://hacker-news.firebaseio.com/v0/item/$id.json');
          Map<String, dynamic> map = responseNews.data;
          final data = News.fromJson(map);

          //final result =  (responseNews.data).map((e) => News.fromJson(e));
          newsList.add(data);
        }
      }
      return newsList;
    } on DioError catch(err){
      throw err.message;
    }
  }

  // static Future<List<dynamic>> getTopStory() async{
  //   Response response = await get(Uri.parse(Api.topStories));
  //   if(response.statusCode == 200){
  //     final List<dynamic> result = jsonDecode(response.body);
  //
  //     return result;
  //
  //   } else{
  //     throw Exception(response.reasonPhrase);
  //   }
  // }


}