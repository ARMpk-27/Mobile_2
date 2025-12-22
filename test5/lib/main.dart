import 'package:flutter/material.dart';
import 'MoneyBox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/* ---------- State ---------- */
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:  EdgeInsets.all(15.0),
        margin:  EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              height: 120,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20)),
              child: InputDecoratorExample(),  
            ),
            Moneybox("ยอดคงเหลือ", 20000.123, 100, Colors.green, 20),
            Moneybox("รายรับ", 1000.456, 100,  Color.fromARGB(255, 242, 105, 47), 20),
            Moneybox("รายจ่าย", 1000.768, 100,  Color.fromARGB(255, 26, 209, 255), 20),
            Moneybox("ค้างจ่าย", 5000.89, 100, Colors.purple, 20),
            Container(
              child: TextButton(
                child: Text("botton", style: TextStyle(fontSize: 30), 
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              onPressed: () {

              },
            ),
            ),
          ],
        
        ),
      ),
    );
  }
}

class InputDecoratorExample extends StatelessWidget {
  const InputDecoratorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Account Name',
        labelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            final Color color =
                states.contains(WidgetState.error)
                    ? Theme.of(context).colorScheme.error
                    : Colors.orange;
            return TextStyle(
              color: color,
              letterSpacing: 1.3,
            );
          },
        ),
      ),
      validator: (String? value) {
        if (value == null || value == '') {
          return 'Enter name';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
    );
  }
}
