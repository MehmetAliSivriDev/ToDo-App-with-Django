import 'package:flutter/material.dart';
import 'package:todoapp_django/product/const/product_border_radius.dart';
import 'package:todoapp_django/product/const/product_paddings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController controller,
    required String hintText,
  })  : _hintText = hintText,
        _controller = controller;

  final TextEditingController _controller;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPaddings.all5(),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: ProductBorderRadius.circularHigh()),
            hintText: _hintText),
      ),
    );
  }
}
