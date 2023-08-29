class TaskModel {
  String id;
  String title;
  String descrebtion;
  int date;
  bool IsDone;

  TaskModel(
      {required this.id,
      required this.title,
      required this.descrebtion,
      required this.date,
      required this.IsDone});

  TaskModel.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          descrebtion: json["descrebtion"],
          date: json["date"],
          IsDone: json["IsDone"],
        );

  Map<String, dynamic> Tojson(){
    return {
      "id":id,
      "title":title,
      "descrebtion":descrebtion,
      "date":date,
      "IsDone":IsDone,
    };
  }
}
