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
      home: GradeApp(),
    );
  }
}

class GradeApp extends StatefulWidget {
  const GradeApp({super.key});

  @override
  State<GradeApp> createState() => _GradeAppState();
}

class _GradeAppState extends State<GradeApp> {
  final nameController = TextEditingController();
  final workController = TextEditingController();
  final midController = TextEditingController();
  final finalController = TextEditingController();

  String major = "INE";
  String subject = "060255104";

  double total = 0;
  String grade = "";

  void calculateGrade() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณากรอกชื่อ - นามสกุล")),
      );
      return;
    }

    double work = double.tryParse(workController.text) ?? 0;
    double mid = double.tryParse(midController.text) ?? 0;
    double fin = double.tryParse(finalController.text) ?? 0;

    total = work + mid + fin;

    if (total > 100) total = 100;

    if (total >= 80) {
      grade = "A";
    } else if (total >= 70) {
      grade = "B";
    } else if (total >= 60) {
      grade = "C";
    } else if (total >= 50) {
      grade = "D";
    } else {
      grade = "F";
    }

    setState(() {});
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HW6 : Grade Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: inputStyle("ชื่อ - นามสกุล"),
            ),

            const SizedBox(height: 15),

            const Text(
              "สาขาวิชา",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: const Text("INE"),
              value: "INE",
              groupValue: major,
              onChanged: (v) => setState(() => major = v!),
            ),
            RadioListTile(
              title: const Text("INET"),
              value: "INET",
              groupValue: major,
              onChanged: (v) => setState(() => major = v!),
            ),

            const SizedBox(height: 10),

            const Text(
              "รหัสวิชา",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: subject,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "060255104", child: Text("060255104")),
                DropdownMenuItem(value: "060233119", child: Text("060233119")),
                DropdownMenuItem(value: "060233209", child: Text("060233209")),
                DropdownMenuItem(value: "060233214", child: Text("060233214")),
              ],
              onChanged: (v) => setState(() => subject = v!),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: workController,
              keyboardType: TextInputType.number,
              decoration: inputStyle("คะแนนเก็บ"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: midController,
              keyboardType: TextInputType.number,
              decoration: inputStyle("คะแนนกลางภาค"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: finalController,
              keyboardType: TextInputType.number,
              decoration: inputStyle("คะแนนปลายภาค"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculateGrade,
              child: const Text("คำนวณเกรด"),
            ),

            const SizedBox(height: 20),

            if (grade.isNotEmpty)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ชื่อ: ${nameController.text}"),
                      Text("สาขา: $major"),
                      Text("รหัสวิชา: $subject"),
                      const Divider(),

                      Text("คะแนนเก็บ: ${workController.text}"),
                      Text("คะแนนกลางภาค: ${midController.text}"),
                      Text("คะแนนปลายภาค: ${finalController.text}"),
                      Text("คะแนนรวม: ${total.toStringAsFixed(0)}"),

                      const SizedBox(height: 10),

                      Text(
                        "เกรด: $grade",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
