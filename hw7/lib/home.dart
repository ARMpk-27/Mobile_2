import 'package:flutter/material.dart';
import 'rec.dart';
import 'tri.dart';
import 'cir.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // 0 = Area, 1 = Volume

  String selectedShape = 'Rectangle';

  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final baseController = TextEditingController();
  final radiusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (double.tryParse(value) == null) return 'Invalid number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Geometric Area Calculator'
              : 'Geometric Volume Calculator',
        ),
        centerTitle: true,
      ),

      body: _currentIndex == 0 ? areaUI() : volumeUI(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.square_foot), label: 'Area'),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar),
            label: 'Volume',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // ---------------- AREA UI ----------------
  Widget areaUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('Rectangle'),
                    value: 'Rectangle',
                    groupValue: selectedShape,
                    onChanged: (v) => setState(() => selectedShape = v!),
                  ),
                  RadioListTile(
                    title: Text('Triangle'),
                    value: 'Triangle',
                    groupValue: selectedShape,
                    onChanged: (v) => setState(() => selectedShape = v!),
                  ),
                  RadioListTile(
                    title: Text('Circle'),
                    value: 'Circle',
                    groupValue: selectedShape,
                    onChanged: (v) => setState(() => selectedShape = v!),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            if (selectedShape == 'Rectangle') ...[
              inputField('Height', heightController),
              inputField('Width', widthController),
            ],

            if (selectedShape == 'Triangle') ...[
              inputField('Height', heightController),
              inputField('Base', baseController),
            ],

            if (selectedShape == 'Circle') ...[
              inputField('Radius', radiusController),
            ],

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(Icons.calculate),
              label: Text('Calculate Area'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (selectedShape == 'Rectangle') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Rec(
                          height: double.parse(heightController.text),
                          width: double.parse(widthController.text),
                        ),
                      ),
                    );
                  }
                  if (selectedShape == 'Triangle') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Tri(
                          height: double.parse(heightController.text),
                          base: double.parse(baseController.text),
                        ),
                      ),
                    );
                  }
                  if (selectedShape == 'Circle') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            Cir(radius: double.parse(radiusController.text)),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- VOLUME UI ----------------
  Widget volumeUI() {
    return Center(
      child: Text(
        'Volume Calculator\n(นักศึกษาพัฒนาต่อ)',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, color: Colors.grey),
      ),
    );
  }

  Widget inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: validateNumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.edit),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
