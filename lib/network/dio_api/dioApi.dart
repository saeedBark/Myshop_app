import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio ;

 static inti(){
     dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

      ),

     );

  }

  static Future<Response> getData({
  required String url,
    Map<String,dynamic>? query,
    String? token,
    String lang = 'en',

}) async {
   dio.options.headers = {
     'Content-Type' : 'application/json',
    'lang' : lang,
    'Authorization' : token,
   };
   return await dio.get(url,queryParameters: query,);
  }

  static Future<Response> postData({
  required String url,
   //  String? value,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang = 'ar',
    String? token ,
}) async{
  dio.options.headers ={
    'Content-Type' : 'application/json',
    'lang' : lang,
    'Authorization' : token??'',

  };
  return await dio.post(url,data: data,queryParameters: query,);
  }

}