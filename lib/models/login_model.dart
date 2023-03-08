class UserLoginModel{
  bool? status;
  String? message;
   Data? data;
  UserLoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data']  != null ? Data.fromJson(json['data']) : null;
  }
}
class Data{
 late int id ;
 late String name ;
 late String email ;
 late String  phone ;
 late String image ;
 late dynamic points ;
 late  dynamic credit ;
 late  String token;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }


}