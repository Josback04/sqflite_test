class Article {
  int? id;
  String name;
  int list;
  double? price;
  String? shop;
  String? image;
  Article(this.id, this.image, this.list, this.name, this.price, this.shop);

  Article.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        list = map["list"],
        price = map["price"],
        shop = map["shop"],
        image = map["image"];
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'image': image,
      'price': price,
      'shop': shop,
      'list': list,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
