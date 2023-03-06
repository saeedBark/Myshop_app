class CategoryModel {
  bool? status;
  DataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  int? current_page;
  List<DataCategory> data = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataCategory.fromJson(element));
    });
  }
}

class DataCategory {
  int? id;
  String? name;
  String? image;
  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
