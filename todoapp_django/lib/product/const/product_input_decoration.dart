import 'package:flutter/material.dart';
import 'package:todoapp_django/product/const/product_colors.dart';
import 'package:todoapp_django/product/const/product_strings.dart';

class ProductInputDecoration extends InputDecoration {
  ProductInputDecoration.searchbarInputDecoration(BuildContext context)
      : super(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: ProductStrings.searchText,
          hintStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: ProductColors.txtwhite),
          prefixIcon: const Icon(
            Icons.search,
            color: ProductColors.txtwhite,
          ),
        );
  ProductInputDecoration.tfInDialogInputDecoration(String text)
      : super(
          fillColor: ProductColors.tfFillColor,
          filled: true,
          hintText: text,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        );
}
