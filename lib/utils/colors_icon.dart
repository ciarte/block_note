
import 'package:flutter/material.dart';

Color iconColor(IconData c) {
    switch (c) {
      case Icons.hail_rounded:
        return Colors.blue;
      case Icons.cabin:
        return Colors.green;
      case Icons.monetization_on:
        return Colors.yellow;
      case Icons.build_rounded:
        return Colors.purple;
      case Icons.cake:
        return Colors.pink;
      case Icons.sailing:
        return Colors.teal;
      case Icons.work_history_outlined:
        return Colors.orange;
      case Icons.phone_forwarded_outlined:
        return Colors.red;
      case Icons.favorite_border_outlined:
        return Colors.redAccent;
      case Icons.place_outlined:
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }