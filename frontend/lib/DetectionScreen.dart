import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectionScreen extends StatelessWidget {
  final String batchId;
  final String tileId;

  const DetectionScreen({super.key, required this.batchId , required this.tileId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detecting'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity, // Make the container take full width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text('Details About the Tile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

              // Container holding Batch ID and Tile ID
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 490.0), // Add margin from left and right
                padding: const EdgeInsets.all(10.0), // Add some padding within the container
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light gray background for better visibility
                  borderRadius: BorderRadius.circular(5.0), // Add some rounded corners
                ),
                child: Column( // Use Row for horizontal alignment
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Batch ID:'),
                        const SizedBox(width: 10.0), // Add some spacing between label and value
                        Flexible(
                          child: Text(batchId),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add spacing between Batch ID and Tile ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Tile ID:'),
                        const SizedBox(width: 10.0), // Add some spacing between label and value
                        Flexible(
                          child: Text(tileId), // Replace with the actual Tile ID
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add spacing between Batch ID and Tile ID
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Edge chippings / Broken corners:'),
                        SizedBox(width: 10.0), // Add some spacing between label and value
                        Flexible(
                          child: Text("N/A"), // Replace with the actual Tile ID
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add spacing between Batch ID and Tile ID
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Surface Defects:'),
                        SizedBox(width: 10.0), // Add some spacing between label and value
                        Flexible(
                          child: Text("N/A"), // Replace with the actual Tile ID
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add spacing between Batch ID and Tile ID
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Line / Crack:'),
                        SizedBox(width: 10.0), // Add some spacing between label and value
                        Flexible(
                          child: Text("N/A"), // Replace with the actual Tile ID
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
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
