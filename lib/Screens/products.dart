import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';

import '../models/category_model.dart';
import '../models/home_model.dart';
import '../style/color.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyshopCubit, MyshopState>(
      listener: (context, state) {
        if(state is MyshopSuccessChangeFavoriteState){
          if(!state.model.status!){
            toastShow(text: state.model.message!, color: Colors.red);
          }

        }
      },
      builder: (context, state) {
        var cubitHome = MyshopCubit.get(context).homemodel;
        var cubitCategory = MyshopCubit.get(context).categoryModel;
        return ConditionalBuilder(
          condition: (cubitHome != null && cubitCategory != null),
          builder: (context) => builderCarouselSlider(cubitHome! ,cubitCategory!,context),
          fallback: (context) =>
               const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
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
            height: 300,
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

        SizedBox(
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
                      modelProduct.oldPrice.toString(),
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
