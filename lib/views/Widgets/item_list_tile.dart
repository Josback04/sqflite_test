import 'package:flutter/material.dart';
import 'package:sqflite_test/models/item_list.dart';

class ItemListWidget extends StatelessWidget {
  ItemList itemList;
  Function(ItemList) onPressed;
  Function(ItemList) onDeleted;

  ItemListWidget(
      {required this.itemList,
      required this.onPressed,
      required this.onDeleted});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        title: Text(itemList.name),
        onTap: (() => onPressed(itemList)),
        trailing: IconButton(
          onPressed: (() => onDeleted(itemList)),
          icon: const Icon(Icons.delete),
        ));
  }
}
