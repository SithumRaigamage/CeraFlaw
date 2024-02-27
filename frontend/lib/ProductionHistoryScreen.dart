import 'package:flutter/material.dart';

class ProductionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press event
        Navigator.pop(context);
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Production History'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ceraflaw_wallpaper.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHistoryEntry('2024-02-26 09:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                _buildHistoryEntry('2024-02-25 15:30', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryEntry(String dateTime, String report) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date/Time: $dateTime',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Report: $report',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
