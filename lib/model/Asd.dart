class Asd {
  Asd({
      this.iconCodePoint, 
      this.title, 
      this.content,});

  Asd.fromJson(dynamic json) {
    iconCodePoint = json['iconCodePoint'];
    title = json['title'];
    content = json['content'];
  }
  int? iconCodePoint;
  String? title;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iconCodePoint'] = iconCodePoint;
    map['title'] = title;
    map['content'] = content;
    return map;
  }

}