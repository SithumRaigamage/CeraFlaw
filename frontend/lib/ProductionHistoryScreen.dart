import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductionHistoryScreen extends StatefulWidget {
  const ProductionHistoryScreen({super.key});

  @override
  _ProductionHistoryScreenState createState() =>
      _ProductionHistoryScreenState();
}

class _ProductionHistoryScreenState extends State<ProductionHistoryScreen> {
  List<dynamic> data = [];
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Production History'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Batch ID")),
                      DataColumn(label: Text("Tile Id")),
                      DataColumn(label: Text("Edge-chipping/Broken-corner")),
                      DataColumn(label: Text("Surface-defects")),
                      DataColumn(label: Text("line/crack")),
                      DataColumn(label: Text("Timestamp")),
                    ],
                    rows: data.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['id'].toString())),
                        DataCell(Text(item['detection'])),
                        DataCell(Text(item['description'])),
                        DataCell(Text(item['timestamp'])),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
