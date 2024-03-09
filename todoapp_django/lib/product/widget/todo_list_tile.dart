import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp_django/features/home/model/todo_model.dart';
import 'package:todoapp_django/product/const/product_box_decoration.dart';
import 'package:todoapp_django/product/const/product_paddings.dart';

class ToDoListTile extends StatelessWidget {
  const ToDoListTile(
      {super.key, required this.filteredList, required this.index});

  final List<ToDoModel>? filteredList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
          padding: const ProductPaddings.all5(),
          decoration: ProductBoxDecoration.listTileDecoration(),
          child: ListTile(
            onTap: () {
              final slidable = Slidable.of(context);

              if (slidable != null) {
                final isClosed =
                    slidable.actionPaneType.value == ActionPaneType.none;
                if (isClosed) {
                  slidable.openStartActionPane();
                } else {
                  slidable.close();
                }
              }
            },
            title: Text(filteredList?[index].title ?? "",
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(filteredList?[index].body ?? "",
                style: Theme.of(context).textTheme.bodyLarge),
          )),
    );
  }
}
