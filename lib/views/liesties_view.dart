import 'package:flutter/material.dart';
import 'package:listry/listy/abstract_listy.dart';
import 'package:listry/listy_store/abstract_listy_store.dart';
import 'package:listry/views/add_listy_view.dart';
import 'package:listry/views/listy_tile.dart';

class ListiesView extends StatefulWidget {
  const ListiesView({Key? key, required this.title, required this.listyStore})
      : super(key: key);

  final String title;
  final AbstractListyStore listyStore;

  @override
  _ListiesViewState createState() => _ListiesViewState();
}

class _ListiesViewState extends State<ListiesView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.listyStore.all(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<AbstractListy> listies =
              snapshot.data as List<AbstractListy>;

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: ListView.builder(
              itemCount: listies.length,
              itemBuilder: (context, index) {
                final listy = listies[index];
                return Dismissible(
                  key: Key(listy.id().toString()),
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
                  child: ListyTile(listy: listy),
                  onDismissed: (direction) {
                    listies.removeAt(index);
                    widget.listyStore
                        .delete(listy)
                        .then((value) => setState(() {}));
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: AddListyView(listyStore: widget.listyStore),
                    );
                  },
                );
                setState(() {});
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('An Error ocured'),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
