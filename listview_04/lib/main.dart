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
      debugShowCheckedModeBanner: false,
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
  Foodmenu('ชาลาเปาหมูสับ', '30', 'assets/images/m1.jpg', 'นึ่ง'),
  Foodmenu('กุ้งเผา', '500', 'assets/images/m2.jpg', 'เผา'),
  Foodmenu('ต้มมะระ', '80', 'assets/images/m3.jpg', 'ต้ม'),
  Foodmenu('ปลาทอด', '120', 'assets/images/m4.jpg', 'ทอด'),
  Foodmenu('แหนมเนือง', '150', 'assets/images/m5.jpg', 'ย่าง'),
  Foodmenu('เบอร์เกอร์', '69', 'assets/images/m6.jpg', 'ทอด'),
  Foodmenu('กระเพราหมู', '80', 'assets/images/m7.jpg', 'ผัด'),
  Foodmenu('ผัดไทย', '70', 'assets/images/m8.jpg', 'ผัด'),
  Foodmenu('ซูซิ', '20', 'assets/images/m9.jpg', 'ดิบ'),
  Foodmenu('บาร์บีคิว', '10', 'assets/images/m10.jpg', 'ย่าง'),
  Foodmenu('ซาลาเปาไส้ครีม', '35', 'assets/images/m11.jpg', 'นึ่ง'),
  Foodmenu('ต้มยำกุ้ง', '120', 'assets/images/m12.jpg', 'ต้ม'),
  Foodmenu('ไก่ทอด', '60', 'assets/images/m13.jpg', 'ทอด'),
  Foodmenu('ปลาหมึกเผา', '150', 'assets/images/m14.jpg', 'เผา'),
  Foodmenu('หมูย่าง', '90', 'assets/images/m15.jpg', 'ย่าง'),
  Foodmenu('ผัดซีอิ๊ว', '70', 'assets/images/m16.jpg', 'ผัด'),
  Foodmenu('ซูชิแซลมอน', '25', 'assets/images/m17.jpg', 'ดิบ'),
  Foodmenu('ข้าวมันไก่', '60', 'assets/images/m18.jpg', 'ต้ม'),
  Foodmenu('ข้าวหมูแดง', '65', 'assets/images/m19.jpg', 'อบ'),
  Foodmenu('ไข่เจียว', '40', 'assets/images/m20.jpg', 'ทอด'),
];


  int count = 0;
  int price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.toString()),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          Foodmenu food = menu[index];
          return ListTile(
              leading: Image.asset(food.imag),
              title: Text("เมนูที่ ${index + 1}" + "." + food.foodname),
              subtitle: Text(" ราคา " + food.foodprice + " บาท "),
              onTap: () {
                count += 1;
                price += int.parse(food.foodprice);
                AlertDialog alert = AlertDialog(
                  title: Text(
                      "คุณได้สั่ง ${food.foodname} , คุณเลือกไปท้ั้งหมด $count จาน  ทั้งหมด $price บาท"),
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    });
              });
        },
      ),
    );
  }
}
