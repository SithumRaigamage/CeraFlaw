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
            top: 0, // Adjusted to position at the top
            left: 20, // Adjusted to position at the left
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Submitted Batch ID: $batchId\n2 by 2 ceramic tile was selected',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ceraflaw_wallpaper.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 2.6, // Adjust aspect ratio as needed
                  children: <Widget>[
                    // div1: Image only
                    Container(
                      color: Colors.white,
                      child: Image.asset("assets/ceramictile2.png",
                          height: 700,
                          width: 1000), // Replace with your image path
                    ),
                    // div2: Text Labels with h1 and other text
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Details About the tile',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)), // h1
                          SizedBox(height: 10),
                          Text('Name :'),
                          Text('Size :'),
                          Text('Defects Indentified :'),
                        ],
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    // div3: Buttons with black text and equal size
                    Container(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue)),
                                child: Text('Check Again',
                                    style: TextStyle(color: Colors.black))),
                          ),
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue)),
                                child: Text('Reject',
                                    style: TextStyle(color: Colors.black))),
                          ),
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue)),
                                child: Text('Pass',
                                    style: TextStyle(color: Colors.black))),
                          ),
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue)),
                                child: Text('Back to Main Menu',
                                    style: TextStyle(color: Colors.black))),
                          ),
                        ],
                      ),
                    ),
                    // div4: Grid Layout of Images
                    Container(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        /*children: List.generate(
                          6, // Total number of images
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/image_$index.png",
                                height: 50,
                                width: 50), // Replace with your image paths
                          ),
                        ),*/
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
