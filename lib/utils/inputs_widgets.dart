import 'package:flutter/material.dart';

TextFormField textInput(
    String title, String errorMessage, TextEditingController controller) {
  return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.text,
      enableSuggestions: false,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: title,
      ),
      validator: (value) {
        String? message;
        if (value == null || value.isEmpty) {
          message = errorMessage;
        }

        return message;
      });
}

TextFormField textEmailInput(
    String title, TextEditingController controller) {
  return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: false,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: title,
      ),
      validator: (value) {
        String? message;
      if (value == null || value.isEmpty) {
        message = 'Please enter your email';
      }
      final emailRegex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if (!emailRegex.hasMatch(value!)) {
        message = 'Please enter an valid email';
      }

      return message;
    },
  );
}

TextFormField textPassInput(
    String title, String errorMessage, TextEditingController controller) {
  return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      enableSuggestions: false,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: title,
      ),
      validator: (value) {
        String? message;
        if (value == null || value.isEmpty) {
          message = errorMessage;
        }

        return message;
      });
}
