
import 'package:flutter/material.dart';

class ContainerDismissible extends StatelessWidget {
  const ContainerDismissible({
    Key? key,
    required this.iconData,
    required this.background,
    required this.iconAxisAligment,
  }) : super(key: key);

  final IconData iconData;
  final Color background;
  final MainAxisAlignment iconAxisAligment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: iconAxisAligment,
          children: [
            Icon(
              iconData,
              size: 32,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
