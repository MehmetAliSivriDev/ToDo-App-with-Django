import 'dart:convert';
import 'dart:io';

import 'package:todoapp_django/features/home/model/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp_django/product/service/api_urls.dart';

abstract class IHomeService {
  Future<List<ToDoModel>?> getToDos();
  Future<String?> deleteToDo(int id);
  Future<ToDoModel?> addToDo(ToDoModel todo);
  Future<ToDoModel?> editToDo(ToDoModel todo);
}

class HomeService extends IHomeService {
  List _dataFromApi = [];

  @override
  Future<List<ToDoModel>?> getToDos() async {
    final response = await http.get(ApiUrls.getToDosUrl);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);

      return _dataFromApi.map((e) => ToDoModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<String?> deleteToDo(int id) async {
    final response = await http.delete(ApiUrls.deleteToDoUrl(id));

    if (response.statusCode == HttpStatus.ok) {
      final result = json.decode(response.body);
      if (result is String) {
        return result;
      }
    }
    return "";
  }

  @override
  Future<ToDoModel?> addToDo(ToDoModel todo) async {
    var body = {"title": todo.title, "body": todo.body};
    var data = <String, dynamic>{};

    final response = await http.post(ApiUrls.addToDoUrl, body: body);

    if (response.statusCode == HttpStatus.ok) {
      data = json.decode(response.body);
      return ToDoModel.fromJson(data);
    } else {
      return ToDoModel(
        title: "Error",
        body: "An error occurred while adding the to do.",
      );
    }
  }

  @override
  Future<ToDoModel?> editToDo(ToDoModel todo) async {
    var body = {"title": todo.title, "body": todo.body};
    var data = <String, dynamic>{};

    final response =
        await http.put(ApiUrls.editToDoUrl(todo.id ?? -1), body: body);

    if (response.statusCode == HttpStatus.ok) {
      data = json.decode(response.body);
      print(data);
      return ToDoModel.fromJson(data);
    } else {
      return ToDoModel(
        title: "Error",
        body: "An error occurred while editing the to do.",
      );
    }
  }
}
