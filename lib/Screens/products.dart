import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/models/category_model.dart';

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
        var cubitCategory = MyshopCubit.get(context).categorymodel;
        return ConditionalBuilder(
          condition: (cubitHome != null && cubitCategory != null),
          builder: (context) => builderCarouselSlider(cubitHome! ,cubitCategory!,context),
          fallback: (context) =>
               Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
