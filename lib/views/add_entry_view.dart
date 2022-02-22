import 'package:flutter/material.dart';
import 'package:listry/listy/abstract_listy.dart';

class AddEntryView extends StatelessWidget {
  AddEntryView({Key? key, required this.listy}) : super(key: key);

  final AbstractListy listy;

  final TextEditingController nameController = TextEditingController(),
      amountController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Amount:'),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
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
                final entries = await listy.getEntries();

                var exists = false;

                for (var element in entries) {
                  if (await element.getName() == nameController.text) {
                    exists = true;
                  }
                }

                if (exists) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Name allready exists!'),
                          content: const Text(
                              'The name you have chosen does allready exist in your List.'),
                          actions: [
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  await listy.createEntry(
                    nameController.text,
                    int.tryParse(amountController.text) ?? 1,
                    false,
                  );
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
