import 'package:flutter/material.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'List Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Data {
  late int id;
  late String name;
  late DateTime t;
  Data(this.id, this.name, this.t);
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String txt = 'N/A';
  List<Data> mylist = <Data>[];
  int img = 0;
  final List<String> _imagePaths = [
    'assets/images/ig.png',
    'assets/images/line.png',
    'assets/images/avengers.png',
    'assets/images/marvel.png',
  ];

  String _imageForId(int id) {
    if (id < 1 || id > _imagePaths.length) {
      return _imagePaths.first;
    }
    return _imagePaths[id - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          RadioGroup(
            groupValue: img,
            onChanged: (int? value) {
              setState(() {
                img = value!;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(value: 1),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/ig.png'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 2),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/line.png'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 3),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/avengers.png'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 4),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/marvel.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextField(controller: _controller),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                txt = 'Add item Successfully';
                mylist.add(
                  Data(
                    img,
                    _controller.text.isEmpty ? "N/A" : _controller.text,
                    DateTime.now(),
                  ),
                );
              });
            },
            child: const Text('Add Item'),
          ),
          SizedBox(height: 15),
          Text(txt, textScaleFactor: 2, style: TextStyle(fontSize: 12)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 80,
                  height: 80,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          _imageForId(mylist[index].id),
                        ),
                      ),
                      title: Text(mylist[index].name),
                      subtitle: Text(mylist[index].t.toString()),
                      trailing: const Icon(Icons.delete_rounded),
                      onTap: () {
                        setState(() {
                          txt = 'Delete ${mylist[index].name} Successfully';
                          mylist.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
