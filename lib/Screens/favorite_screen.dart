import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';



class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MyshopCubit.get(context).favoritesModel.data!.data;
    return BlocConsumer<MyshopCubit, MyshopState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition: state is! MyshopLoadingGetFavoritesDataState ,
      builder:(context) => ListView.separated(
          itemBuilder: (context,index) =>buildProductItems(cubit[index].product!,context, ),
          separatorBuilder:(context,index) =>const Divider(thickness: 1,height: 1,),
          itemCount: cubit!.length,
      ),
      fallback: (context) =>const Center(child: CircularProgressIndicator()),
    );
  },
);
  }



}
