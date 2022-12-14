class CommentModel {
  String? by;
  int? id;
  List? kids;
  int? parent;
  String? text;
  int? time;
  String? type;

  CommentModel(
      {this.by,
        this.id,
        this.text,
      });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      by: json['by'],
      id: json['id'],
      text: json['text'],
      );
  }
}