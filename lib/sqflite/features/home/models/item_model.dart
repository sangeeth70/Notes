class Item {
  int? id;
  String title;
  String description;

  Item({required this.title, required this.description, this.id});

  // Map item to a Map for database storage and retrieval
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Create item from a Map (used for reading from database)
  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'];
}