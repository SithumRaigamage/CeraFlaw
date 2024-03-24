import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class ProductionHistoryScreen extends StatefulWidget {
  const ProductionHistoryScreen({Key? key}) : super(key: key);

  @override
  _ProductionHistoryScreenState createState() =>
      _ProductionHistoryScreenState();
}

class _ProductionHistoryScreenState extends State<ProductionHistoryScreen> {
  List<dynamic> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProduction();
  }

  Future<void> loadProduction() async {
    try {
      final currentDirectory = Directory.current;
      final filePath = '${currentDirectory.path}/production_history.json';
      final file = File(filePath);
      if (!await file.exists()) {
        print('File does not exist at the specified path.');
        setState(() {
          isLoading = false;
          data = [{'error': 'File not found'}]; // Update data with an error message
        });
        return;
      }
      String jsonContent = await file.readAsString();
      List<dynamic> jsonData = json.decode(jsonContent);

      setState(() {
        data = jsonData;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading history: $e");
      setState(() {
        isLoading = false;
        data = [{'error': 'Failed to load data'}]; // Update data with an error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Production History'),
          ],
        ),
        // Center the title horizontally
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            child: isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Batch ID")),
                        DataColumn(label: Text("Tile ID")),
                        DataColumn(label: Text("Edge Chippings")),
                        DataColumn(label: Text("Surface Defects")),
                        DataColumn(label: Text("Line/Crack")),
                      ],
                      rows: data.map((entry) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(entry['batchId'] ?? 'N/A')),
                          DataCell(Text(entry['tileId'] ?? 'N/A')),
                          DataCell(Text(entry['edge_chipping_count'].toString())),
                          DataCell(Text(entry['surface_defect_count'].toString())),
                          DataCell(Text(entry['line_crack_count'].toString())),
                        ],
                      )).toList(),
                    ),
                  ),
          ),
          Expanded(
            child: Container(), // Added to fill the remaining space
          ),
        ],
      ),
    );
  }
}
