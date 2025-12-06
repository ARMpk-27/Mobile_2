import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorUI());
}

class CalculatorUI extends StatelessWidget {
  const CalculatorUI({super.key});

  final Color bgColor = const Color(0xFF22252D);
  final Color numberBtn = const Color(0xFF2A2D37);
  final Color funcBtn = const Color(0xFFF69906);
  final Color controlBtn = const Color(0xFF4E505F);

  Widget buildButton(String text, Color color, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {}, // ยังไม่ทำงาน
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              // ====== DISPLAY ======
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                alignment: Alignment.bottomRight,
                child: const Text(
                  "0",
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),

              // ====== BUTTON ROWS ======
              Row(
                children: [
                  buildButton("C", controlBtn),
                  buildButton("%", controlBtn),
                  buildButton("÷", funcBtn),
                ],
              ),

              Row(
                children: [
                  buildButton("7", numberBtn),
                  buildButton("8", numberBtn),
                  buildButton("9", numberBtn),
                  buildButton("×", funcBtn),
                ],
              ),

              Row(
                children: [
                  buildButton("4", numberBtn),
                  buildButton("5", numberBtn),
                  buildButton("6", numberBtn),
                  buildButton("-", funcBtn),
                ],
              ),

              Row(
                children: [
                  buildButton("1", numberBtn),
                  buildButton("2", numberBtn),
                  buildButton("3", numberBtn),
                  buildButton("+", funcBtn),
                ],
              ),

              Row(
                children: [
                  buildButton("0", numberBtn, flex: 2),  // ปุ่ม 0 = 2 ช่อง
                  buildButton(".", numberBtn),
                  buildButton("=", funcBtn),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
