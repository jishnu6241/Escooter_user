import 'package:flutter/material.dart';

class LabelWithText extends StatelessWidget {
  final String label, text;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? labelColor, textColor;
  const LabelWithText({
    super.key,
    required this.label,
    required this.text,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.labelColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: labelColor ?? Colors.black87,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: textColor ?? Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
