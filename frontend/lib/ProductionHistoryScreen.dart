import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ProductionHistoryScreen extends StatefulWidget {
 const ProductionHistoryScreen({Key? key}) : super(key: key);

 @override
 _ProductionHistoryScreenState createState() => _ProductionHistoryScreenState();
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
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/production_history.json');
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
    print('Parsed JSON data: $jsonData'); // Debugging
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
        child: isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                 columns: const [
                    DataColumn(label: Text("Batch ID")),
                    DataColumn(label: Text("Tile Id")),
                    DataColumn(label: Text("Edge-chipping/Broken-corner")),
                    DataColumn(label: Text("Surface-defects")),
                    DataColumn(label: Text("line/crack")),
                    DataColumn(label: Text("Timestamp")),
                 ],
                 rows: data.map((entry) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(entry['batchId'] ?? 'N/A')),
                        DataCell(Text(entry['tileId'] ?? 'N/A')),
                        DataCell(Text(entry['edge_chipping_count'].toString())),
                        DataCell(Text(entry['surface_defect_count'].toString())),
                        DataCell(Text(entry['line_crack_count'].toString())),
                        DataCell(Text(entry['timestamp'].toString())),
                      ],
                    );
                 }).toList(),
                ),
              ),
      ),
    );
 }
}
