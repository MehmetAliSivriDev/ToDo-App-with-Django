class ToDoModel {
  int? id;
  String? title;
  String? body;
  String? updated;
  String? created;

  ToDoModel({this.id, this.title, this.body, this.updated, this.created});

  ToDoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    updated = json['updated'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['updated'] = this.updated;
    data['created'] = this.created;
    return data;
  }
}
