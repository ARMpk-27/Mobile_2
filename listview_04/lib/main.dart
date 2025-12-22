import 'package:flutter/material.dart';

import 'foodmenu.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Foodmenu> menu = [
    Foodmenu('ชาลาเปาหมูสับ', '30'),
    Foodmenu('กุ้งเผา', '500'),
    Foodmenu('ต้มมะระ', '80'),
    Foodmenu('ปลาทอด', '120'),
    Foodmenu('แหนมเนือง', '150'),
    Foodmenu('เบอร์เกอร์', '69'),
    Foodmenu('กระเพราหมู', '80'),
    Foodmenu('ผัดไทย', '70'),
    Foodmenu('ซูซิ', '20'),
    Foodmenu('บาร์บีคิว', '10'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hello'),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
        Foodmenu food = menu[index];
        return ListTile(
          title: Text('Item ${index+1}'+''+food.foodname),
          subtitle: Text('${food.foodname} ราคา ${food.foodprice} บาท'),
        );
      
      }
    ));
  }
}
