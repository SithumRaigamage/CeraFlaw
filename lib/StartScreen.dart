
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Tile Size and Enter Batch ID'),
        ),
        body: GridAndFlowLayout(),
      ),
    );
  }
}

class GridAndFlowLayout extends StatefulWidget {
  @override
  _GridAndFlowLayoutState createState() => _GridAndFlowLayoutState();
}

class _GridAndFlowLayoutState extends State<GridAndFlowLayout> {
  String batchId = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return GridTile(
                child: Column(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle button press
                        },
                        icon: Image.asset(
                          'assets/image.png',
                          fit: BoxFit.cover,
                        ),
                        label: Text('Button $index'),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Batch Id',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      batchId = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle submit button press
                  print('Submitted Batch ID: $batchId');
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
