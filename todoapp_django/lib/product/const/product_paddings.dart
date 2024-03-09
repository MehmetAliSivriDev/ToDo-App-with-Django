import 'package:flutter/material.dart';

class ProductPaddings extends EdgeInsets {
  const ProductPaddings.scaffoldPadding() : super.all(10);
  const ProductPaddings.onlyTop15() : super.only(top: 15);
  const ProductPaddings.all5() : super.all(5);
}
