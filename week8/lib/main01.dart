import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* ---------------- MyApp ---------------- */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'List Example'),
    );
  }
}

/* ---------------- Home Page ---------------- */
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/* ---------------- data class ---------------- */
class data {
  late int id;
  late String name;
  late DateTime t;

  data(this.id, this.name, this.t);
}

/* ---------------- State ---------------- */
class _MyHomePageState extends State<MyHomePage> {
  String txt = 'N/A';
  List<data> mylist = <data>[];
  int img = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* -------- Row Radio + Avatar -------- */
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: img,
                  onChanged: (int? value) {
                    setState(() {
                      img = 1;
                    });
                  },
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/ig.png'),
                ),
              ],
            ),

            /* -------- TextField -------- */
            const TextField(),

            /* -------- Add Button -------- */
            ElevatedButton(
              onPressed: () {
                setState(() {
                  txt = "Add item Success";
                  mylist.add(
                    data(img, '1', DateTime.now()),
                  );
                });
              },
              child: const Text('Add Item'),
            ),

            /* -------- Status Text -------- */
            Text(
              txt,
              textScaleFactor: 2,
            ),

            /* -------- ListView -------- */
            SizedBox(
              width: double.infinity,
              height: 550,
              child: ListView.builder(
                itemCount: mylist.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.primaries[
                          index % Colors.primaries.length],
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/rocket.png'),
                        ),
                        title:
                            Text('Title Text (${mylist[index].id})'),
                        subtitle: Text(mylist[index].t.toString()),
                        trailing:
                            const Icon(Icons.delete_rounded),
                        onTap: () {
                          setState(() {
                            txt = "Title Text ($index) is remove";
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
      ),
    );
  }
}
