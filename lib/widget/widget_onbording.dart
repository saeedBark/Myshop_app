import 'package:flutter/material.dart';
import 'package:my_shop_app/models/onbording_model.dart';

  Widget onbordingItem( OnbordingModel model ) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset('${model.image}',)),
        SizedBox(height: 20,),
        Text('${model.title}',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Text('${model.bodytitle} ',style: TextStyle(fontSize: 24,),),
      ],);
  }
