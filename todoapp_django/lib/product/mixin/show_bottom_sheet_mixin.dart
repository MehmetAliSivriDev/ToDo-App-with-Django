import 'package:flutter/material.dart';

mixin ShowBottomSheet {
  Future<T?> showCustomSheet<T>(BuildContext context, Widget widget) async {
    return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: widget,
          );
        });
  }
}
