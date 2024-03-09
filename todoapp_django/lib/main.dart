import 'package:flutter/material.dart';
import 'package:todoapp_django/features/home/view/home_view.dart';
import 'package:todoapp_django/product/const/product_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App with Django',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ProductColors.hlBlack),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
