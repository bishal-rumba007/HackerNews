
class News {
  String? by;
  int? id;
  List? kids;
  int? score;
  String? title;
  String? url;

  News({
    this.by,
    this.id,
    this.kids,
    this.score,
    this.title,
    this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      by: json['by'],
      id: json['id'],
      kids: json['kids'],
      score: json['score'],
      title: json['title'],
      url: json['url'],
    );
  }
}