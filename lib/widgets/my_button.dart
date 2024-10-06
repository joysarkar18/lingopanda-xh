import 'package:flutter/material.dart';
import 'package:lingopanda_xh/constants/colors_constants.dart';
import 'package:lingopanda_xh/constants/text_styles_constants.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool isLoading;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.height = 49.0,
    this.width = 231.0,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: AppColors.bgWhite,
                )
              : Text(
                  text,
                  style:
                      PoppinsTextStyle.bold(fontSize: 16, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
