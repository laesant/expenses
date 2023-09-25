import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField(
      {super.key,
      this.autofocus = false,
      required this.controller,
      this.textInputAction,
      required this.label,
      this.keyboardType,
      this.onSubmitted});
  final bool autofocus;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String label;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            autofocus: autofocus,
            controller: controller,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            placeholder: label,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          )
        : TextField(
            autofocus: autofocus,
            controller: controller,
            textInputAction: textInputAction,
            decoration: InputDecoration(labelText: label),
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
          );
  }
}
