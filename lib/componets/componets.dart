import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/models/category_model.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/style/color.dart';


////////////////




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