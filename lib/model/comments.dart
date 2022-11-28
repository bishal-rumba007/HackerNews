class Comments {
  String? by;
  int? id;
  List? kids;
  int? parent;
  String? text;
  int? time;
  String? type;

  Comments(
      {this.by,
        this.id,
        this.kids,
        this.parent,
        this.text,
        this.time,
        this.type});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      by: json['by'],
      id: json['id'],
      parent: json['parent'],
      text: json['text'],
      time: json['time'],
      type: json['type'],
    );
  }
}