import 'package:escooter/values/colors.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomProgressIndicator({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? primaryColor,
      backgroundColor: color != null
          ? color!.withOpacity(0.1)
          : primaryColor.withOpacity(0.1),
    );
  }
}
