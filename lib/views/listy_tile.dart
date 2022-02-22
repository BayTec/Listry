import 'package:flutter/material.dart';
import 'package:listry/listy/abstract_listy.dart';
import 'package:listry/views/listy_view.dart';

class ListyTile extends StatefulWidget {
  const ListyTile({Key? key, required this.listy}) : super(key: key);

  final AbstractListy listy;

  @override
  _ListyTileState createState() => _ListyTileState();
}

class _ListyTileState extends State<ListyTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FutureBuilder(
        future: widget.listy.getName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final String name = snapshot.data as String;

            return Text(name);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An Error ocured'),
            );
          }

          return const Center(
            child: LinearProgressIndicator(),
          );
        },
      ),
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListyView(
                listy: widget.listy,
              ),
            ),
          );
        });
      },
    );
  }
}
