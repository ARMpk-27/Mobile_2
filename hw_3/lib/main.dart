import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = "0";
  String operator = "";
  double firstNum = 0;
  double secondNum = 0;
  double percentValue = 0;

  final Color bgColor = const Color(0xFF22252D);
  final Color numberBtn = const Color(0xFF2A2D37);
  final Color funcBtn = const Color(0xFFF69906);
  final Color controlBtn = const Color(0xFF4E505F);

  void buttonPressed(String value) {
    setState(() {
      // A. CLEAR
      if (value == "C") {
        display = "0";
        operator = "";
        firstNum = 0;
        secondNum = 0;
        percentValue = 0;
        return;
      }

      // A. DEL
      if (value == "DEL") {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = "0";
        }
        return;
      }

      // D. SQUARE ROOT
      if (value == "√") {
        double num = double.parse(display);
        display = sqrt(num).toString();
        if (display.endsWith(".0")) {
          display = display.replaceAll(".0", "");
        }
        return;
      }

      // C. POWER
      if (value == "^") {
        firstNum = double.parse(display);
        operator = "^";
        display = "0";
        return;
      }

      // B. PERCENT
      if (value == "%") {
        percentValue = double.parse(display);
        operator = "%";
        display = "0";
        return;
      }

      // OPERATORS
      if (["+", "-", "×", "÷"].contains(value)) {
        firstNum = double.parse(display);
        operator = value;
        display = "0";
        return;
      }

      // DECIMAL
      if (value == ".") {
        if (!display.contains(".")) {
          display += ".";
        }
        return;
      }

      // EQUAL
      if (value == "=") {
        secondNum = double.parse(display);

        switch (operator) {
          case "+":
            display = (firstNum + secondNum).toString();
            break;
          case "-":
            display = (firstNum - secondNum).toString();
            break;
          case "×":
            display = (firstNum * secondNum).toString();
            break;
          case "÷":
            display = secondNum == 0 ? "Error" : (firstNum / secondNum).toString();
            break;
          case "^":
            display = pow(firstNum, secondNum).toString();
            break;
          case "%":
            display = ((percentValue / 100) * secondNum).toString();
            break;
        }

        if (display.endsWith(".0")) {
          display = display.replaceAll(".0", "");
        }

        operator = "";
        return;
      }

      // NUMBER INPUT
      if (display == "0") {
        display = value;
      } else {
        display += value;
      }
    });
  }

  Widget buildButton(String text, Color color, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(text),
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
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // DISPLAY
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: const TextStyle(fontSize: 56, color: Colors.white),
              ),
            ),

            Row(children: [
              buildButton("C", controlBtn),
              buildButton("DEL", controlBtn),
              buildButton("%", controlBtn),
              buildButton("√", funcBtn),
            ]),

            Row(children: [
              buildButton("7", numberBtn),
              buildButton("8", numberBtn),
              buildButton("9", numberBtn),
              buildButton("÷", funcBtn),
            ]),

            Row(children: [
              buildButton("4", numberBtn),
              buildButton("5", numberBtn),
              buildButton("6", numberBtn),
              buildButton("×", funcBtn),
            ]),

            Row(children: [
              buildButton("1", numberBtn),
              buildButton("2", numberBtn),
              buildButton("3", numberBtn),
              buildButton("-", funcBtn),
            ]),

            Row(children: [
              buildButton("0", numberBtn, flex: 2),
              buildButton("^", funcBtn),
              buildButton("=", funcBtn),
            ]),
          ],
        ),
      ),
    );
  }
}
