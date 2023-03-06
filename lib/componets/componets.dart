import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/models/category_model.dart';
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
      validator: (value) => validator(value),
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
      onPressed: () {
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

void toastShow({required String text, required Color color}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

String token = '';

////////

Widget builderCarouselSlider(HomeData model,CategoryModel modelCate ,context) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners
              .map(
                (e) => Image(
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
        ),
        SizedBox(height: 5,),
        Text('Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),

        Container(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => builderCategory(modelCate.data!.data[index],context),
              separatorBuilder: (context,index) =>SizedBox(width: 15,),
              itemCount: modelCate.data!.data.length,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text('Products',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.8,
            children: List.generate(
                model.data!.products.length,
                (index) =>
                    buliderProduit(model.data!.products[index], context))),
      ],
    ),
  );
}

//////////////builderProduct////////
Widget buliderProduit(Products modelProduct, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage('${modelProduct.image!}'),
              width: double.infinity,
              height: 200,
              //  fit: BoxFit.cover,
            ),
            if(modelProduct.discount != 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,),
              color: Colors.red,
                child: Text('DUSCOUNT',style: TextStyle(color: Colors.white),),),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                modelProduct.name!,
                style: TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(modelProduct.price.toString()),
                  SizedBox(
                    width: 5,
                  ),
                  if (modelProduct.discount != 0)
                    Text(
                      modelProduct.old_price.toString(),
                      style: TextStyle(
                          color: Colors.grey, decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
///////////builderCatogryItem////

Widget builderCategory(DataCategory model,context){
 return Stack(
   alignment: Alignment.bottomCenter,
   children: [
     Image(image: NetworkImage(model.image!),height: 100,width: 100,),
     Container(
       width: 100,
       color: Colors.black.withOpacity(0.7),
         child: Text(model.name!,style: TextStyle(color: Colors.white),textAlign: TextAlign.center),),
   ],
 );

}