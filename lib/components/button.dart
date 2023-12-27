import 'package:flutter/material.dart';
import 'package:youappflutter/components/custom_text.dart';
import 'package:youappflutter/constants/color_constant.dart';
import 'package:youappflutter/constants/string_constant.dart';
import 'package:youappflutter/extensions/context_extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.05)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.teal,
            fixedSize: Size(
              context.dynamicWidth(1),
              context.dynamicHeight(0.06),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: CustomText(
          buttonText,
          textStyle: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
