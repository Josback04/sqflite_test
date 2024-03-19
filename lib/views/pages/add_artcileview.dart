import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_test/models/article.dart';
import 'package:sqflite_test/services/database_client.dart';
import 'package:sqflite_test/views/Widgets/add_textfield.dart';
import 'package:sqflite_test/views/Widgets/custom_appbar.dart';

class AddArticlePage extends StatefulWidget {
  final int listId;
  const AddArticlePage({required this.listId, super.key});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  late TextEditingController nameController;
  late TextEditingController shopController;
  late TextEditingController priceController;
  String? imgPath;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    shopController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    shopController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          buttonTitle: 'Valider',
          callback: addPressed,
          titleString: 'Ajouter un article'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Nouvel Article',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Card(
                  elevation: 10,
                  child: Column(children: [
                    (imgPath == null)
                        ? Icon(
                            Icons.photo,
                            size: 128,
                          )
                        : Image.file(File(imgPath!)),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: (() => takePicture(ImageSource.camera)),
                            icon: const Icon(Icons.camera_alt)),
                        IconButton(
                            onPressed: (() => takePicture(ImageSource.gallery)),
                            icon: const Icon(Icons.photo_library))
                      ],
                    ),
                    AddTextField(controller: nameController, hint: 'nom'),
                    AddTextField(controller: shopController, hint: 'Shop'),
                    AddTextField(controller: priceController, hint: '000Fc')
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (nameController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
    map['name'] = nameController.text;
    if (shopController.text.isNotEmpty) map["shop"] = shopController;
    double price = double.tryParse(priceController.text) ?? 0.0;
    map['price'] = price;
    if (imgPath != null) map['image'] = imgPath!;
    Article article = Article.fromMap(map);
    DatabaseClient()
        .upsert(article)
        .then((success) => Navigator.of(context).pop());
  }

  takePicture(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    setState(() {
      imgPath = xFile.path;
    });
  }
}
