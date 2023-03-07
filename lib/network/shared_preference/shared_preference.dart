
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceCach{
static late SharedPreferences  sharedPreference;

static inti() async{
   sharedPreference = await SharedPreferences.getInstance();
 }

static dynamic getData({
  required String key,
}){
  return sharedPreference.get(key);
 }

 static Future<dynamic> saveData({
   required String key,
   required dynamic value,
}) async{
  if(value is int) return await sharedPreference.setInt(key, value);
  if(value is String) return await sharedPreference.setString(key, value);
  if(value is double) return await sharedPreference.setDouble(key, value);
  else
    return await sharedPreference.setBool(key, value);
 }

static Future<dynamic> logout({
  required String key,
}) async{
 return await sharedPreference.remove(key);
}

}