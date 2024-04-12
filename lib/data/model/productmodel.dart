class ProductModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;
  String? catName;
  late int quantity;

  //contructor
  ProductModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.des,
    this.catId,
    this.catName,
    this.quantity = 0,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    img = json["img"];
    des = json["des"];
    catId = json["catId"];
    catName = json["catName"];
    quantity = json["quantity"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["img"] = img;
    data["des"] = des;
    data["catId"] = catId;
    data["catName"] = catName;
    data["quantity"] = quantity;
    return data;
  }
}
