class ChangeFavoritModel{
  bool? status ;
  String? message;
  ChangeFavoritModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}