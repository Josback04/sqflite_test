import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_test/models/article.dart';

class ArticleTile extends StatelessWidget {
  Article article;
  ArticleTile({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(article.name),
          if (article.image != null)
            Container(
              child: Image.file(
                File(article.image!),
              ),
            ),
          Text('Prix: ${article.price} FC'),
          Text('Magasin: ${article.shop}'),
        ],
      ),
    );
  }
}
