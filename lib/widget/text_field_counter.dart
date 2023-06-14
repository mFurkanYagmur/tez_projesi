import 'package:flutter/material.dart';

Widget? buildTextFieldCounter(
  BuildContext context, {
  required int currentLength,
  required int? maxLength,
  required bool isFocused,
}) {
  if (maxLength== null) {
    return null;
  } else if (currentLength==0) {
    return null;
  } else if (currentLength>0 && !isFocused) {
    return null;
  } else {
    return Text('$currentLength/$maxLength', style: Theme.of(context).textTheme.bodySmall,);
  }
}