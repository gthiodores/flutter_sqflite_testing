class Note {
  final int? id;
  final String title;
  final String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      title: map["title"],
      description: map["description"],
    );
  }

  Note copy({int? id, String? title, String? description}) => Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
}
