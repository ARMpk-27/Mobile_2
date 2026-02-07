import 'package:flutter/material.dart';

class Tri extends StatelessWidget {
  final double height;
  final double base;

  Tri({required this.height, required this.base});

  @override
  Widget build(BuildContext context) {
    double area = 0.5 * height * base;

    return Scaffold(
      appBar: AppBar(title: Text('Triangle Area')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Height: $height'),
            Text('Base: $base'),
            SizedBox(height: 20),
            Text(
              'Area = $area',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
