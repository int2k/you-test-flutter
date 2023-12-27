import 'package:flutter/material.dart';
import 'package:youappflutter/components/custom_text.dart';
import 'package:youappflutter/constants/color_constant.dart';
import 'package:youappflutter/extensions/context_extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.disabled = false,
  });

  final String buttonText;
  final VoidCallback onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.05)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF62CDCB),
            fixedSize: Size(
              context.dynamicWidth(1),
              context.dynamicHeight(0.06),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        child: CustomText(
          buttonText,
          textStyle: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
