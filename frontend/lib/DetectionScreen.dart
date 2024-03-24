import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectionScreen extends StatefulWidget {
  final String batchId;
  final String tileId;

  const DetectionScreen({super.key, required this.batchId, required this.tileId});

  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  Map<String, dynamic>? countData;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch initial data
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchData(); // Fetch data every 1 seconds
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/get_counts'));
      if (response.statusCode == 200) {
        setState(() {
          countData = Map<String, dynamic>.from(json.decode(response.body));
        });
      } else {
        print('Failed to fetch counts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveCountDataToJson(String batchIdForHistory, String tileIdForHistory) async {
  try {
    final directory = Directory.current;
    final file = File('${directory.path}/production_history.json');

    // Check if the file exists
    if (await file.exists()) {
      // Read existing data if the file exists
      String existingData = await file.readAsString();

      // Check if the existing data is a list
      List<dynamic>? existingList;
      try {
        existingList = json.decode(existingData) as List<dynamic>;
      } catch (e) {
        print('Error: Existing data is not a valid JSON list: $e');
        // Handle potential errors here (e.g., create a new file or log a warning)
      }

      // Create a new map with new data
      Map<String, dynamic> newData = {
        'batchId': batchIdForHistory,
        'tileId': tileIdForHistory,
        'edge_chipping_count': countData?['edge_chipping_count'],
        'surface_defect_count': countData?['surface_defect_count'],
        'line_crack_count': countData?['line_crack_count'],
      };

      // If existing list is valid, append new data
      if (existingList != null) {
        existingList.add(newData);
        await file.writeAsString(json.encode(existingList));
        print('Count data appended to existing list');
      } else {
        // If existing data is not a list, create a new list with the new data
        List<dynamic> newList = [newData];
        await file.writeAsString(json.encode(newList));
        print('Count data saved to new file (as a list)');
      }
    } else {
      // If the file doesn't exist, create a new list with the new data
      List<dynamic> newList = [{
        'batchId': batchIdForHistory,
        'tileId': tileIdForHistory,
        'edge_chipping_count': countData?['edge_chipping_count'],
        'surface_defect_count': countData?['surface_defect_count'],
        'line_crack_count': countData?['line_crack_count'],
      }];
      await file.writeAsString(json.encode(newList));
      print('Count data saved to new file (as a list)');
    }
  } catch (e) {
    print('Error saving count data to file: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detecting'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text('Details About the Tile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 490.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Batch ID:'),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text(widget.batchId),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Tile ID:'),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text(widget.tileId),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Edge chippings:'),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text(countData?['edge_chipping_count'].toString() ?? 'N/A'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Surface Defects:'),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text(countData?['surface_defect_count'].toString() ?? 'N/A'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Line / Crack:'),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text(countData?['line_crack_count'].toString() ?? 'N/A'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Warning'),
                      content: const Text('Quitting this will terminate the program'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            try {
                              // Send a GET request to stop the script execution
                              var response = await http.get(
                                Uri.parse('http://localhost:5000/?stop=true'),
                              );
                              if (response.statusCode == 200) {
                                print('Python script terminated successfully');
                                await saveCountDataToJson(widget.batchId,widget.tileId);
                              } else {
                                print(
                                    'Failed to terminate Python script: ${response.statusCode}');
                              }
                            } catch (e) {
                              print('Error: $e');
                            }
                            Navigator.pop(context); // Close the dialog
                            Navigator.pop(context); // Close the dialog to return to the main menu
                          },
                          child: const Text('Quit'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text('Back to Main Menu', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
