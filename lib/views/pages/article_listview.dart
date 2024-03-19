import 'package:flutter/material.dart';
import 'package:sqflite_test/models/item_list.dart';
import 'package:sqflite_test/services/database_client.dart';
import 'package:sqflite_test/models/article.dart';
import 'package:sqflite_test/views/Widgets/article_tile.dart';
import 'package:sqflite_test/views/Widgets/custom_appbar.dart';
import 'package:sqflite_test/views/pages/add_artcileview.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({required this.itemList, super.key});
  final ItemList itemList;

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  List<Article> articles = [];

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
            buttonTitle: "+",
            callback: addNewItem,
            titleString: widget.itemList.name),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            itemBuilder: ((context, index) =>
                ArticleTile(article: articles[index])),
            itemCount: articles.length));
  }

  getArticles() async {
    DatabaseClient().articlesFromId(widget.itemList.id).then((articles) {
      setState(() {
        this.articles = articles;
      });
    });
  }

  addNewItem() {
    final next = AddArticlePage(
      listId: widget.itemList.id,
    );
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (context) => next);
    Navigator.of(context)
        .push(materialPageRoute)
        .then((value) => getArticles());
  }
}
