class Room {
  String id;
  String title;
  String description;
  String categoryId;

  static const String COLLECTION_NAME='Room ';


  Room({ this.id='', required this.title, required this.description, required this.categoryId});

  Room.formJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    categoryId: json['categoryId'],

  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryId': categoryId,

    };
  }
}
