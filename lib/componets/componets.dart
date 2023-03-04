import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/models/login_model.dart';

////////// default FormFile//////////
Widget defaultFormFile({
  required TextEditingController controller,
  Function? onsubmit,

  required String lable,
  required IconData prefix,
  Function()? onTap,
  TextInputType? type,
  required Function validator,
  IconData? suffix,
  bool enable = true,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: (d) {
        onsubmit!(d);
      },
      validator:(value) => validator(value),
      onTap: () {
        onTap!();
      },
      enabled: enable,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? Icon(suffix) : null,
        border: OutlineInputBorder(),
      ),
    );
////////////////

Widget defaultButton({
  Color color = const Color(0xFFD319C2),
  double width = double.infinity,
  double raduis = 15,
  bool isUpperCase = true,
  required Function fanction,
  required String text,
}) {
  return Container(
    height: 40,
    width: width,
    child: MaterialButton(
      onPressed:() {
        fanction();
      },

      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      color: color,
    ),
  );
}
/////////

Widget defaultText(
    {required String text,
     double? fontSize,
     FontWeight? fontWeidght,
     Color? color}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeidght,
      fontSize: fontSize,
    ),
  );
}
/////////////Toast Show ///////

void toastShow({
  required String text,
  required Color color
}) =>   Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);

String token = '';

////////

Widget builderCarouselSlider(HomeData model) {
  return CarouselSlider(
      items:model!.data!.banners
          .map(
            (e) =>
            Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
      )
          .toList(),

    options: CarouselOptions(
      height: 250,
      initialPage: 0,
      viewportFraction: 1.0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),
  );
}