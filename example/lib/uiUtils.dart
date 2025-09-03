import 'package:flutter/material.dart';

class UiUtils {
  static Widget createButton(String name, Function callback) {
    return ElevatedButton(
        onPressed: callback,
        child: Text(name),
        color: Colors.blue,
        textColor: Colors.white);
  }
}