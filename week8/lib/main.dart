import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.db;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Manager',
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final data = await DatabaseHelper.instance.queryAllUsers();
    setState(() {
      users = data.map((e) => User.fromMap(e)).toList();
    });
  }

  void addUser() {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add New User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.insertUser(
                User(
                  username: usernameController.text,
                  email: emailController.text,
                ),
              );
              fetchUsers();
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void editUser(User user) {
    TextEditingController usernameController =
        TextEditingController(text: user.username);
    TextEditingController emailController =
        TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.updateUser(
                User(
                  id: user.id,
                  username: usernameController.text,
                  email: emailController.text,
                ),
              );
              fetchUsers();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GFG User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await DatabaseHelper.instance.deleteAllUsers();
              fetchUsers();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index) {
          final user = users[index];
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(user.username),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => editUser(user),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteUser(user.id!);
                    fetchUsers();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        child: Icon(Icons.add),
      ),
    );
  }
}
