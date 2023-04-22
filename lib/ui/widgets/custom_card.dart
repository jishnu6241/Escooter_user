import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Color? color, hoverColor;
  const CustomCard({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 10,
      shadowColor: Colors.black38,
      color: color ?? Colors.green[50],
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        hoverColor: hoverColor,
        child: child,
      ),
    );
  }
}
