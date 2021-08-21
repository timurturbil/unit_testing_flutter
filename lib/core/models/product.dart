class Product {
  int id;
  String name;
  int price;
  String imageUrl;

  Product({this.id, this.name, this.price, this.imageUrl});
  
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }
}
