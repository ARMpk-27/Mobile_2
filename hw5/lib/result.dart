import 'dart:math';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String userNumber;
  final int buyMoney;

  const ResultPage({
    super.key,
    required this.userNumber,
    required this.buyMoney,
  });

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    String luckyNumber =
        "${random.nextInt(10)}${random.nextInt(10)}${random.nextInt(10)}";

    bool isWin = userNumber == luckyNumber;
    int reward = isWin ? buyMoney * 100 : 0;

    return Scaffold(
      appBar: AppBar(title: const Text("ผลการออกรางวัล")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "เลขที่คุณซื้อคือ $userNumber",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "จำนวนเงินที่คุณซื้อคือ $buyMoney บาท",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            Text(
              "* เลขที่ออกคือ $luckyNumber",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            isWin
                ? Text(
                    "* ยินดีด้วย คุณถูกรางวัล",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  )
                : Text(
                    "* เสียใจด้วย คุณไม่ถูกรางวัล",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),

            if (isWin)
              Text(
                "* รับเงินรางวัล $reward บาท",
                style: const TextStyle(fontSize: 18),
              ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("กลับหน้าหลัก"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}