import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String label) {
  return InputDecoration(
      hintText: label,
      fillColor: Colors.red,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(64)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(64),
          borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(64),
          borderSide: BorderSide(color: Colors.indigo, width: 4)));
}
