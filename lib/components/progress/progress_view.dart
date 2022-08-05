import 'package:flutter/material.dart';
import 'package:new_bytebank/components/progress/circularProgress.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progressing"),
      ),
      body: CircularProgress(
        message: 'Sending...',
      ),
    );
  }
}
