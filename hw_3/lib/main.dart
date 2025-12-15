
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

/* ---------- Root App ---------- */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator UI',
      home: CalApp(),
    );
  }
}

/* ---------- Calculator Page ---------- */
class CalApp extends StatefulWidget {
  const CalApp({super.key});

  @override
  State<CalApp> createState() => _CalAppState();
}

class _CalAppState extends State<CalApp> {
  String num1 = "";
  String num2 = "";
  String operator = "";
  String display = "0";

  void pressNumber(String num) {
    setState(() {
      if (operator.isEmpty) {
        num1 += num;
        display = num1;
      } else {
        num2 += num;
        display = num2;
      }
    });
  }

  void pressOperator(String op) {
    setState(() {
      operator = op;
    }); 
  }

  void clear() {
    setState(() {
      num1 = "";
      num2 = "";
      operator = "";
      display = "0";
    });
  }

  void calculate() {
    if (num1.isNotEmpty || num2.isNotEmpty || operator.isNotEmpty) {
      double n1 = double.parse(num1);
      double n2 = double.parse(num2);
      double result = 0;

      switch (operator) {
        case "+":
          result = n1 + n2;
          break;
        case "-":
          result = n1 - n2;
          break;
        case "*":
          result = n1 * n2;
          break;
        case "/":
          result = n1 / n2;
          break;
      }

      setState(() {
        display = result.toString();
        num1 = result.toString();
        num2 = "";
        operator = "";
      });
    }
  }
  

  Widget calcBtn(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            display,
            style: const TextStyle(fontSize: 40, color: Colors.red),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              calcBtn("7", () => pressNumber("7")),
              calcBtn("8", () => pressNumber("8")),
              calcBtn("9", () => pressNumber("9")),
              calcBtn("+", () => pressOperator("+")),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              calcBtn("4", () => pressNumber("4")),
              calcBtn("5", () => pressNumber("5")),
              calcBtn("6", () => pressNumber("6")), 
              calcBtn("-", () => pressOperator("-")),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              calcBtn("1", () => pressNumber("1")),
              calcBtn("2", () => pressNumber("2")),
              calcBtn("3", () => pressNumber("3")),
              calcBtn("*", () => pressOperator("*")),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              calcBtn("0", () => pressNumber("0")),
              calcBtn("C", () => clear()),
              calcBtn("=", () => calculate()),
              calcBtn("/", () => pressOperator("/")),
            ],
          ),
        ],
      ),
    );
  }
}
