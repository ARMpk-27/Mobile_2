import 'package:flutter/material.dart';

class Rec extends StatelessWidget {
  final double height;
  final double width;

  Rec({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    double area = height * width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rectangle Area'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Height : $height', style: TextStyle(fontSize: 18)),
                Text('Width  : $width', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Text(
                  'Area = $area',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
