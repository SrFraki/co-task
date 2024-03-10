import 'package:flutter/material.dart';
import 'package:task_sharing/config/theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.text, this.onTap, {super.key, this.color, this.backgroundColor});

  final void Function() onTap;
  final String text;
  final Color? backgroundColor, color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          height: 60,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? ATheme.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: ATheme.shadow
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                color: color ?? Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
