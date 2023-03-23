import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/models/category_model.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/style/color.dart';

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
        style: const TextStyle(color: Colors.white),
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

dynamic token = SharedPreferenceCach.getData(key: 'token');
//SharedPreferenceCach.getData(key: 'token');

////////

Widget builderCarouselSlider(HomeData model,CategoryModel modelCate ,context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
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
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 5,),
        const Text('Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        const SizedBox(height: 10,),

        Container(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => builderCategory(modelCate.data!.data[index],context),
              separatorBuilder: (context,index) =>const SizedBox(width: 15,),
              itemCount: modelCate.data!.data.length,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text('Products',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              color: Colors.red,
                child: const Text('DUSCOUNT',style: TextStyle(color: Colors.white),),),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                modelProduct.name!,
                style: const TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(modelProduct.price.toString()),
                  const SizedBox(
                    width: 5,
                  ),
                  if (modelProduct.discount != 0)
                    Text(
                      modelProduct.old_price.toString(),
                      style: const TextStyle(
                          color: Colors.grey, decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      MyshopCubit.get(context).changFavorite( modelProduct.id!);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: MyshopCubit.get(context).favorits[modelProduct.id]!? defaultColor :Colors.grey  ,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Colors.white,
                      ),
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
         child: Text(model.name!,style: const TextStyle(color: Colors.white),textAlign: TextAlign.center),),
   ],
 );

}
/////////builder item search and favorites//////////
Widget buildProductItems( model, context,{bool inSearch=true} ) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage((model.image)!),
              width: 120,
              height: 120,
            ),
            if((model.discount) != 0&&inSearch)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: const Text('Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.name)!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text((model.price.toString()),
                    style: const TextStyle(
                        fontSize: 12,
                        color: defaultColor
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if((model.discount) != 0&&inSearch)
                    Text(model.discount.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      MyshopCubit.get(context).changFavorite(
                          model.id!
                      );
                      // print(model.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor: MyshopCubit
                            .get(context)
                            .favorits[model.id]!
                            ? defaultColor
                            : Colors.grey,
                        radius: 15,
                        child: const Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
// Widget builderProductItem( model,context,{bool isOldPrice = true}) =>  Container(
//   height: 130,
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           Image(
//             image: NetworkImage(model.image!),
//             width: 100,
//             height: 100,
//             //  fit: BoxFit.cover,
//           ),
//           if(model.discount != 0 && isOldPrice)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10,),
//               color: Colors.red,
//               child: const Text('DUSCOUNT',style: TextStyle(color: Colors.white),),),
//         ],
//       ),
//       const SizedBox(width: 15,),
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text(
//                 model.name!,
//                 style: const TextStyle(fontSize: 16),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 5,),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                       model.price.toString()
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   if (model.discount != 0  && isOldPrice)
//                     Text(
//                       model.oldPrice.toString(),
//                       style: const TextStyle(
//                           color: Colors.grey, decoration: TextDecoration.lineThrough),
//                     ),
//                   const Spacer(),
//                   IconButton(
//                     onPressed: () {
//                       MyshopCubit.get(context).changFavorite( model.id!);
//                     },
//                     icon: CircleAvatar(
//                       radius: 15,
//                       backgroundColor:MyshopCubit.get(context).favorits[model.id]! ? defaultColor :Colors.grey  ,
//                       child: const Icon(
//                         Icons.favorite_border,
//                         size: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// );