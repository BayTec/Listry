import 'package:flutter/material.dart';
import 'package:listry/entry/abstract_entry.dart';
import 'package:listry/listy/abstract_listy.dart';
import 'package:listry/views/add_entry_view.dart';
import 'package:listry/views/entry_tile.dart';

class ListyView extends StatefulWidget {
  const ListyView({Key? key, required this.listy}) : super(key: key);

  final AbstractListy listy;

  @override
  _ListyViewState createState() => _ListyViewState();
}

class _ListyViewState extends State<ListyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: widget.listy.getName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final name = snapshot.data as String;
              return Text(name);
            } else if (snapshot.hasError) {
              return const Text('Error');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      body: FutureBuilder(
          future: widget.listy.getEntries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final entries = snapshot.data as List<AbstractEntry>;
              return ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Dismissible(
                    key: Key(entry.id().toString()),
                    secondaryBackground: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete),
                    ),
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: const Icon(Icons.delete),
                    ),
                    child: EntryTile(entry: entry),
                    onDismissed: (direction) {
                      entries.removeAt(index);
                      widget.listy.deleteEntry(entry).then((value) => setState(
                            () {},
                          ));
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: const Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: AddEntryView(listy: widget.listy),
              );
            },
          );
          setState(() {});
        },
      ),
    );
  }
}
