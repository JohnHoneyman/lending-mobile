import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonName;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double borderRadius;
  final Size minimumSize;
  final VoidCallback onPress;
  const Button({
    super.key,
    required this.buttonName,
    this.textStyle = const TextStyle(color: Colors.white),
    this.backgroundColor = const Color(0xff65558f),
    this.borderRadius = 8,
    this.minimumSize = const Size(double.infinity, 50),
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: minimumSize,
      ),
      onPressed: onPress,
      child: Text(
        buttonName,
        style: textStyle,
      ),
    );
  }
}
