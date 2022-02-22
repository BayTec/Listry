import 'package:flutter/material.dart';
import 'package:listry/database/sqflite_database.dart';
import 'package:listry/listy_store/database_listy_store.dart';
import 'package:listry/views/liesties_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listry',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const MyHomePage(title: 'Lists'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final database = SqfliteDatabase();

  @override
  Widget build(BuildContext context) {
    final listyStore = DatabaseListyStore(database);

    return ListiesView(
      title: widget.title,
      listyStore: listyStore,
    );
  }
}

/*
class _MyHomePageState extends State<MyHomePage> {
  Future<Directory> getDirectory() async {
    final directory = Directory(
        join((await getApplicationDocumentsDirectory()).path, 'lists'));

    await directory.create(recursive: true);

    return directory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDirectory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final directory = snapshot.data as Directory;
          final listyStore = FileListyStore(IoFileStore(directory));

          return ListiesView(
            title: widget.title,
            listyStore: listyStore,
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
*/