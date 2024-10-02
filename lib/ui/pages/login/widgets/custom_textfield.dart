import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildTextformField extends StatelessWidget {
  BuildTextformField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.enableObscure = false,
      this.fillColor,
      this.customValidator});

  final String hintText;
  final TextEditingController controller;
  final bool enableObscure;
  final TextInputType keyboardType;
  final Color? fillColor;

  String? Function(String?)? customValidator;

  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: Colors.black12,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );

  final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );

  bool obscure = true;
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return TextFormField(
        // autocorrect: true,
        // autofocus: true,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        // cursorColor: kWhite,
        validator: (value) {
          if (value != null && value.trim().isEmpty) {
            return "*required";
          }

          if (customValidator != null) {
            return customValidator!.call(value);
          }

          return null;
        },
        obscureText: enableObscure && obscure,
        obscuringCharacter: "*",
        style: const TextStyle(
            // color: kWhite,
            ),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: const TextStyle(
              // color: kWhite,
              ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          suffixIcon: Visibility(
            visible: enableObscure,
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    obscure = !obscure;
                  },
                );
              },
              child: Icon(
                obscure ? Icons.visibility : Icons.visibility_off,
                // color: kWhite,
              ),
            ),
          ),
        ),
      );
    });
  }
}
