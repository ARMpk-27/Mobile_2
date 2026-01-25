import 'package:flutter/material.dart';
import 'display.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormpageState();

}

class _FormpageState extends State<FormPage>{
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void checknumber(){
    if (_controller.text.isEmpty){
      setState(() {
        _errorText = 'กรุณากรอกตัวเลข';
      });
      return;
    }
    final int? number = int.tryParse(_controller.text);
    if (number == null){
      setState(() {
        _errorText = 'กรุณากรอกตัวเลขเท่านั้น';
      });
      return;
    }
    Navigator.push(
      context, 
      
      MaterialPageRoute(
        builder: (context) => DisplayPage(number: number),
      )
    );
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตรวจสอบเลขคี่-เลขคู่'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'กรุณากรอกตัวเลข',
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checknumber,
              child: const Text('ตรวจสอบ'),
            ),
          ],
        ),
      ),
    );
  }
}