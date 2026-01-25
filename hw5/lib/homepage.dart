import 'package:flutter/material.dart';
import 'result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController d1 = TextEditingController();
  final TextEditingController d2 = TextEditingController();
  final TextEditingController d3 = TextEditingController();
  final TextEditingController money = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("6706022510468")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("เลือกเลขท้าย 3 หลัก", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [box(d1), box(d2), box(d3)],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: money,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "จำนวนเงินที่ต้องการซื้อ (บาท)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                String number = d1.text + d2.text + d3.text;
                int buyMoney = int.parse(money.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResultPage(userNumber: number, buyMoney: buyMoney),
                  ),
                );
              },
              child: const Text("ตรวจรางวัล"),
            ),
          ],
        ),
      ),
    );
  }

  Widget box(TextEditingController controller) {
    return Container(
      width: 60,
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}