import 'package:youappflutter/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youappflutter/constants/color_constant.dart';
import 'package:youappflutter/extensions/num_extensions.dart';
import 'package:youappflutter/extensions/context_extensions.dart';
import '../utils/typedefs.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.title,
    this.isPassword = false,
    this.onSaved,
    this.keyboardType = TextInputType.text,
  });

  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final ValidatorFunction validator;
  final bool? isPassword;
  final TextInputType? keyboardType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {

  @override
  Widget build(BuildContext context) {
    var emptyText = widget.title?.isEmpty ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.ph,
        if (emptyText) CustomText(
          widget.title ?? "",
          textStyle: context.textTheme.titleMedium,
        ),
        if (emptyText) 10.ph,
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onSaved: widget.onSaved,
          cursorColor: ColorConstants.teal,
          obscureText: widget.isPassword ?? false,
          style: GoogleFonts.inter(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorStyle: GoogleFonts.inter(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: ColorConstants.inputBorder.withOpacity(0.21))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: ColorConstants.inputBorder)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: ColorConstants.inputBorder)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}