import 'package:flutter/material.dart';
import 'package:my_shop_app/models/onbording_model.dart';

  Widget onbordingItem( OnbordingModel model ) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(model.image,)),
        const SizedBox(height: 20,),
        Text(model.title,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        Text('${model.bodyTitle} ',style: const TextStyle(fontSize: 24,),),
      ],);
  }
