class ListModel {
  final String id;
  final String imageUrl;
  final String title;
  bool? favorite=false;

  ListModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.favorite
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'],
      imageUrl: json['image_url'],
      title: json['title'],
      favorite: json['favorite']!= null &&  json['favorite'] > 0 ? true : false
    );
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      id: map['id'],
      imageUrl: map['image_url'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'title': title,
      'favorite':favorite
    };
  }
}

