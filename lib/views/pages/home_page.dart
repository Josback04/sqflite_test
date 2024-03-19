import 'package:flutter/material.dart';
import 'package:sqflite_test/models/item_list.dart';
import 'package:sqflite_test/services/database_client.dart';
import 'package:sqflite_test/views/Widgets/add_dialog.dart';
import 'package:sqflite_test/views/Widgets/custom_appbar.dart';
import 'package:sqflite_test/views/Widgets/item_list_tile.dart';
import 'package:sqflite_test/views/pages/article_listview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ItemList> items = [];

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
        body: ListView.separated(
          itemBuilder: ((context, index) {
            final item = items[index];
            return ItemListWidget(
                itemList: item,
                onPressed: onListPressed,
                onDeleted: onDeleteItem);
          }),
          separatorBuilder: ((context, index) => const Divider()),
          itemCount: items.length,
        ));
  }

  getItemList() async {
    final fromDb = await DatabaseClient().allItem();
    setState(() {
      items = fromDb;
    });
  }

  void addItemList() async {
    final controller = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) {
          return AddDialog(
              controller: controller,
              onAdded: (() {
                handleCloseDialog();
                if (controller.text.isEmpty) return;
                DatabaseClient()
                    .addItemList(controller.text)
                    .then((success) => getItemList());
              }),
              onCancel: handleCloseDialog);
        });

    print('enregistrement done');
  }

  handleCloseDialog() {
    Navigator.pop(context);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onListPressed(ItemList itemList) {
    final next = ArticleListView(itemList: itemList);
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (context) => next);
    Navigator.of(context).push(materialPageRoute);
  }

  onDeleteItem(ItemList itemList) {
    DatabaseClient().removeItem(itemList).then((sucess) => getItemList());
  }
}
