import 'package:flutter/material.dart';
import 'package:sqflite_test/models/item_list.dart';
import 'package:sqflite_test/services/database_client.dart';
import 'package:sqflite_test/views/Widgets/custom_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ItemList> item = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          buttonTitle: "Ajouter",
          callback: addItemList,
          titleString: "Ma liste de souhait"),
      body: Center(child: Text("nous avons ${item.length} elements")),
    );
  }

  getItemList() async {
    final fromDb = await DatabaseClient().allItem();
    setState(() {
      item = fromDb;
    });
  }

  addItemList() {}
}
