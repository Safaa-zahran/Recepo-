class ProductsModel {
  int? id;
  String? title;
  String? image;
  int? price;

  ProductsModel({this.id, this.title, this.price, this.image});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
