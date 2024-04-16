class NoteModel {
  final int id;
  final String title;
  final String content;
  final String date;

  NoteModel({
    this.id = 0,
    required this.title,
    required this.content,
    required this.date,
  });

  //Convert into Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  //Convert Map object to normal

  static NoteModel fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}
