import 'package:flutter/material.dart';
import 'package:listry/listy_store/abstract_listy_store.dart';

class AddListyView extends StatelessWidget {
  AddListyView({Key? key, required this.listyStore}) : super(key: key);

  final AbstractListyStore listyStore;

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Row(
              children: [
                const Text('Name:'),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                var listyNames =
                    await listyStore.all().then<List<String>>((value) async {
                  List<String> names = [];

                  for (var element in value) {
                    names.add(await element.getName());
                  }

                  return names;
                });

                if (listyNames
                    .any((element) => element == nameController.text)) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Name taken!'),
                          content: const Text('This name is taken.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      });
                } else {
                  await listyStore.create(nameController.text);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
