import 'package:flutter/material.dart';

class DetectionScreen extends StatelessWidget {
  final String batchId;

  DetectionScreen({required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Submitted Batch ID: $batchId\n2 by 2 ceramic tile was selected',
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
