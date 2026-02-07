import 'package:flutter/material.dart';
import 'dart:math';

class Cir extends StatelessWidget {
  final double radius;

  Cir({required this.radius});

  @override
  Widget build(BuildContext context) {
    double area = pi * radius * radius;

    return Scaffold(
      appBar: AppBar(
        title: Text('Circle Area'),
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
                Text('Radius : $radius', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Text(
                  'Area = $area',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
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
