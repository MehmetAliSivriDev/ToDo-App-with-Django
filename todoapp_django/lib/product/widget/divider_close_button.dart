import 'package:flutter/material.dart';
import 'package:todoapp_django/product/extensions/context_extension.dart';

class DividerCloseButton extends StatelessWidget {
  const DividerCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.05),
      child: Stack(
        children: [
          Divider(
            color: Colors.black,
            thickness: 3,
            indent: context.dynamicWidth(0.4),
            endIndent: context.dynamicWidth(0.4),
          ),
          Positioned(
              top: 5,
              right: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              )),
        ],
      ),
    );
  }
}
