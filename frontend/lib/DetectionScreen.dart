import 'package:flutter/material.dart';

class DetectionScreen extends StatelessWidget {
  // Adjust constructor parameters if needed
  final String batchId;

  DetectionScreen({required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'), // Change the title if needed
      ),
      body: Center(
        child: Text('Submitted Batch ID: $batchId'),
      ),
    );
  }
}
