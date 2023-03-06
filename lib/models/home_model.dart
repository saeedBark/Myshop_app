class HomeData{
 bool? status;
 Data? data;
HomeData.fromJson(Map<String,dynamic> json){
  status = json['status'];
  data = (json['data'] != null ? Data.fromJson(json['data'])  : null)!;
}
}
class Data{
  List<Banners> banners = [];
  List<Products> products = [];
Data.fromJson(Map<String,dynamic> json){

  json['banners'].forEach((element) {
    banners.add(Banners.fromJson(element));
  });
  json['products'].forEach((element){
    products.add(Products.fromJson(element));
  });

}
}

class Banners{
 late int id;
 late String image;
 Banners.fromJson(Map<String,dynamic> json){
  id = json['id'];
  image= json['image'];
 }
}
class Products{
  int? id;
 dynamic? price;
 dynamic? old_price;
  dynamic? discount;
 String? name;
 String? image;
 bool? in_favorites;
Products.fromJson(Map<String,dynamic> json){
  id = json['id'];
  image = json['image'];
  price= json['price'];
  old_price= json['old_price'];
  discount= json['discount'];
  name= json['name'];
  in_favorites= json['in_favorites'];
}

}