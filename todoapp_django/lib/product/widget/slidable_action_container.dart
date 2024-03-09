import 'package:flutter/material.dart';
import 'package:todoapp_django/product/const/product_border_radius.dart';
import 'package:todoapp_django/product/const/product_colors.dart';
import 'package:todoapp_django/product/extensions/context_extension.dart';

class SlidableActionContainer extends StatelessWidget {
  const SlidableActionContainer({
    super.key,
    required Color color,
    required IconData icon,
    required String text,
    required Function onTap,
  })  : _onTap = onTap,
        _color = color,
        _icon = icon,
        _text = text;

  final Color _color;
  final IconData _icon;
  final String _text;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => _onTap(),
        child: Container(
          height: context.dynamicHeight(1),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: ProductBorderRadius.circularNormal(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_icon, color: ProductColors.txtwhite),
              Text(_text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ProductColors.txtwhite))
            ],
          ),
        ),
      ),
    );
  }
}
