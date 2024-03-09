import 'package:flutter/material.dart';
import 'package:todoapp_django/features/home/model/todo_model.dart';
import 'package:todoapp_django/features/home/service/home_service.dart';
import 'package:todoapp_django/features/home/view/home_view.dart';
import 'package:todoapp_django/product/const/product_colors.dart';
import 'package:todoapp_django/product/const/product_strings.dart';
import 'package:todoapp_django/product/service/api_response.dart';

abstract class HomeViewModel extends State<HomeView> {
  var hour = DateTime.now().hour;
  var time = "${DateTime.now().hour} ${DateTime.now().minute}";

  bool isLoading = false;
  late IHomeService _homeService;
  List<ToDoModel>? todos;
  List<ToDoModel>? filteredList;
  BuildContext? _currentContext;

  @override
  void initState() {
    _currentContext = context;
    _homeService = HomeService();
    super.initState();
    getToDos();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void filterList(String word) {
    setState(() {
      if (todos != null && filteredList != null) {
        filteredList = todos
            ?.where((element) =>
                element.title!.toLowerCase().contains(word.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> getToDos() async {
    changeLoading();
    final response = await _homeService.getToDos();
    await Future.delayed(const Duration(seconds: 1));
    todos = response;
    filteredList = todos;
    changeLoading();
  }

  Future<void> deleteToDo(int id) async {
    final response = await _homeService.deleteToDo(id);

    if (response == ApiResponse.deleteSuccess.getRepsonse()) {
      if (_currentContext != null && _currentContext!.mounted) {
        ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
            backgroundColor: ProductColors.successGreen,
            content: Text(ProductStrings.deleteSnackbarSuccessContent)));
        setState(() {
          getToDos();
        });
        Navigator.pop(_currentContext!);
      }
    } else {
      if (_currentContext != null && _currentContext!.mounted) {
        ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
            backgroundColor: ProductColors.delRed,
            content: Text(ProductStrings.deleteSnackbarErrorContent)));
        Navigator.pop(_currentContext!);
      }
    }
  }

  Future<void> addToDo(ToDoModel todo) async {
    final response = await _homeService.addToDo(todo);

    if (response is ToDoModel) {
      if (response.title != ApiResponse.errorTitle.getRepsonse()) {
        if (_currentContext != null && _currentContext!.mounted) {
          ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
              backgroundColor: ProductColors.successGreen,
              content: Text(ProductStrings.addSnackbarSuccessContent)));
          setState(() {
            getToDos();
          });
          Navigator.pop(_currentContext!);
        }
      } else {
        if (_currentContext != null && _currentContext!.mounted) {
          ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
              backgroundColor: ProductColors.delRed,
              content: Text(ProductStrings.addSnackbarErrorContent)));
          Navigator.pop(_currentContext!);
        }
      }
    } else {
      if (_currentContext != null && _currentContext!.mounted) {
        ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
            backgroundColor: ProductColors.delRed,
            content: Text(ProductStrings.addSnackbarErrorContent)));
        Navigator.pop(_currentContext!);
      }
    }
  }

  Future<void> editToDo(ToDoModel todo) async {
    final response = await _homeService.editToDo(todo);

    if (response is ToDoModel) {
      if (response.title != ApiResponse.errorTitle.getRepsonse()) {
        if (_currentContext != null && _currentContext!.mounted) {
          ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
              backgroundColor: ProductColors.successGreen,
              content: Text(ProductStrings.editSnackbarSuccessContent)));
          setState(() {
            getToDos();
          });
          Navigator.pop(_currentContext!);
        }
      } else {
        if (_currentContext != null && _currentContext!.mounted) {
          ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
              backgroundColor: ProductColors.delRed,
              content: Text(ProductStrings.editSnackbarErrorContent)));
          Navigator.pop(_currentContext!);
        }
      }
    } else {
      if (_currentContext != null && _currentContext!.mounted) {
        ScaffoldMessenger.of(_currentContext!).showSnackBar(const SnackBar(
            backgroundColor: ProductColors.delRed,
            content: Text(ProductStrings.editSnackbarErrorContent)));
        Navigator.pop(_currentContext!);
      }
    }
  }

  String getTimeAndMessage() {
    if (hour > 6 && hour < 12) {
      return "$time Good Morning!";
    } else if (hour > 12 && hour < 17) {
      return "$time Good Afternoon!";
    } else if (hour > 17 && hour < 21) {
      return "$time Good Evening!";
    } else {
      return "$time Goodnight!";
    }
  }
}
