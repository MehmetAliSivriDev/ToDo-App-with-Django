import 'package:flutter/material.dart';
import 'package:todoapp_django/product/const/product_colors.dart';
import 'package:todoapp_django/product/extensions/image_paths.dart';

class ProductBoxDecoration extends BoxDecoration {
  ProductBoxDecoration.backgroundDecoration()
      : super(
            image: DecorationImage(
                image: AssetImage(ImageJPG.background_image.getPath()),
                fit: BoxFit.fill));
  ProductBoxDecoration.searchbarDecoration()
      : super(
            borderRadius: BorderRadius.circular(20),
            color: ProductColors.sbWhite);
  ProductBoxDecoration.listTileDecoration()
      : super(
            color: ProductColors.bgWhite,
            borderRadius: BorderRadius.circular(15));
}
