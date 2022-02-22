import 'package:flutter/material.dart';
import 'package:listry/entry/abstract_entry.dart';

class EntryTile extends StatefulWidget {
  const EntryTile({Key? key, required this.entry}) : super(key: key);

  final AbstractEntry entry;

  @override
  _EntryTileState createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FutureBuilder(
          future: widget.entry.getAmount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final amount = snapshot.data as int;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${amount}x',
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            }

            return const CircularProgressIndicator();
          }),
      title: FutureBuilder(
          future: widget.entry.getName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final name = snapshot.data as String;
              return Text(name);
            } else if (snapshot.hasError) {
              return const Text('Error');
            }

            return const LinearProgressIndicator();
          }),
      trailing: FutureBuilder(
          future: widget.entry.getChecked(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final checked = snapshot.data as bool;

              return Checkbox(
                value: checked,
                onChanged: (value) {
                  widget.entry
                      .setChecked(value ?? false)
                      .then((value) => setState(() {}));
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            }

            return const CircularProgressIndicator();
          }),
    );
  }
}
