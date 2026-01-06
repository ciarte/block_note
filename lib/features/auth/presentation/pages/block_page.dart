import 'package:flutter/material.dart';

class BlockPage extends StatelessWidget {
  static const String name = 'BlockPage';

  const BlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('block'),
      ));
  }
}