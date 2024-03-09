import 'package:flutter/material.dart';
import 'package:todoapp_django/product/const/product_input_decoration.dart';
import 'package:todoapp_django/product/const/product_paddings.dart';

class TFinAlertDialog extends StatelessWidget {
  const TFinAlertDialog({
    super.key,
    required TextEditingController controller,
    required String hintText,
  })  : _controller = controller,
        _hintText = hintText;

  final TextEditingController _controller;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPaddings.scaffoldPadding(),
      child: TextField(
          controller: _controller,
          decoration:
              ProductInputDecoration.tfInDialogInputDecoration(_hintText)),
    );
  }
}
