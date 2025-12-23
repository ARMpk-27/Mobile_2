import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> menuList = [];
  int count = 1;

  void addMenu() {
    setState(() {
      menuList.add("เมนูที่ $count");
      count++;
    });
  }

  void removeMenu() {
    if (menuList.isNotEmpty) {
      setState(() {
        menuList.removeLast();
        count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HW4 : ListView Builder",
          style: TextStyle(fontSize: 20,
          color: Colors.white),
          
        ),        
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menuList[index]),
          );
        },
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: addMenu,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: removeMenu,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
