import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/colors.dart';

class BuildCustomSearchField extends StatelessWidget {
  const BuildCustomSearchField({
    super.key,
    this.controller,
    this.onTap,
  });

  final TextEditingController? controller;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.sp,
      child: TextField(
        controller: controller,
        onTap: onTap,
        // cursorColor: kBlack,
        decoration: InputDecoration(
          // fillColor: kWhite,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
          ),
          prefixIconColor: Colors.grey,
          hintText: "Search",
          focusColor: kBlack,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: kBlack,
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kBlack,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kBlack,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 5.sp,
            vertical: 5.sp,
          ),
        ),
      ),
    );
  }
}
