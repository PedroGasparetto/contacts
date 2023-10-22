import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class Person {
  String name;
  File image;

  Person(this.name, this.image);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Envolve o aplicativo com o MaterialApp
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Person> people = [];

  Future<void> _addPerson() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String personName = await _getPersonName();
      setState(() {
        people.add(Person(personName, File(pickedFile.path)));
      });
    }
  }

  Future<String> _getPersonName() async {
    String name = "";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nome da Pessoa'),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(people[index].image),
            title: Text(people[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPerson,
        tooltip: 'Adicionar Pessoa',
        child: Icon(Icons.add),
      ),
    );
  }
}
