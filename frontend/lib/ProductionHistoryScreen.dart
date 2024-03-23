import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductionHistoryScreen extends StatefulWidget {
  const ProductionHistoryScreen({super.key});

  @override
  _ProductionHistoryScreenState createState() =>
      _ProductionHistoryScreenState();
}

class _ProductionHistoryScreenState extends State<ProductionHistoryScreen> {
  List<dynamic> data = [];
  String _productContent = "";
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    loadProduction();
  }

  Future<void> loadProduction() async {
  try {
    String filePath = 'assets/history.txt';
    _productContent = await rootBundle.loadString(filePath);
    setState(() {
      data = _productContent.split('\n');
      print(data);
    });
  } catch (e) {
    print("Error loading history: $e");
  }
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
                    rows: data.map((entry) {
                      List<String> rowData = entry.split(',');
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(rowData[0])),
                          DataCell(Text(rowData[1])),
                          DataCell(Text(rowData[2])),
                          DataCell(Text(rowData[3])),
                          DataCell(Text(rowData[4])),
                          DataCell(Text(rowData[5])),
                        ],
                      );
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
