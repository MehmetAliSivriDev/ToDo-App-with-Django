class ApiUrls {
  static final getToDosUrl = Uri.parse("http://10.0.2.2:8000/notes/");
  static deleteToDoUrl(int id) =>
      Uri.parse("http://10.0.2.2:8000/notes/$id/delete/");

  static final addToDoUrl = Uri.parse("http://10.0.2.2:8000/notes/create/");
  static editToDoUrl(int id) =>
      Uri.parse("http://10.0.2.2:8000/notes/$id/update/");
}
