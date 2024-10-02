import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommentTextfield extends StatelessWidget {
  CommentTextfield({
    required this.sendButtonTap,
    this.sendButtonIsLoading = false,
    super.key,
  });

  final ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);
  final void Function(String value) sendButtonTap;
  final bool sendButtonIsLoading;

 final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      cursorHeight: 15,
      onChanged: (value) {
        EasyDebounce.debounce(
          '',
          const Duration(milliseconds: 500),
          () {
            valueNotifier.value = value.trim().isNotEmpty;
          },
        );
      },
      decoration: InputDecoration(
        hintText: "Write your comment ...",
        // fillColor: f1White,
        filled: true,
        suffixIcon: ValueListenableBuilder<bool>(
          valueListenable: valueNotifier,
          builder: (context, value, child) => Visibility(
            visible: value,
            child: IconButton(
              onPressed: () {
                sendButtonTap(
                  textEditingController.text.trim(),
                );
              },
              icon: Builder(builder: (context) {
                if (sendButtonIsLoading) {
                  return const CircularProgressIndicator.adaptive();
                }

                return Icon(
                  Icons.send,
                  size: 13.sp,
                );
              }),
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 7.sp,
        ),
      ),
    );
  }
}
