import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductionHistoryScreen extends StatefulWidget {
  @override
  _ProductionHistoryScreenState createState() => _ProductionHistoryScreenState();
}

class _ProductionHistoryScreenState extends State<ProductionHistoryScreen> {
  List<dynamic> data = [];
  bool isLoading = true; // Track loading state

  Future<void> getData() async {
    var url = Uri.parse('http://192.168.1.78/ceraflaw/getdata.php');
    try {
      var response = await http.get(url);
      // print('HTTP Response status code: ${response.statusCode}');
      // print('HTTP Response body: ${response.body}'); // Debug print
      
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          isLoading = false; // Data is fetched, set loading to false
        });
        // print('Data decoded from JSON: $data'); // Debug print
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Production History'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
                    columns: [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("Detection")),
                      DataColumn(label: Text("Description")),
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
