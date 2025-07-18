// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

Widget indicator({required double value}) {
  return LinearProgressIndicator(
    value: value,
    color: const Color(0xff2e9844),
    backgroundColor: const Color(0xff334155),
  );
}
