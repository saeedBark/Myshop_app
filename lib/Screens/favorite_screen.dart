import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/models/favorite_model.dart';
import 'package:my_shop_app/style/color.dart';


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
          itemBuilder: (context,index) =>builderFavorite(cubit[index].product!,context),
          separatorBuilder:(context,index) =>const Divider(thickness: 1,height: 1,),
          itemCount: cubit!.length,
      ),
      fallback: (context) =>const Center(child: CircularProgressIndicator()),
    );
  },
);
  }

  Widget builderFavorite(Product model,context) =>  Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 100,
              height: 100,
              //  fit: BoxFit.cover,
            ),
            if(model.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,),
                color: Colors.red,
                child: const Text('DUSCOUNT',style: TextStyle(color: Colors.white),),),
          ],
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                 model.name!,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5,),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        model.price.toString()
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                            color: Colors.grey, decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                         MyshopCubit.get(context).changFavorite(product_id: model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:MyshopCubit.get(context).favorits[model.id]! ? defaultColor :Colors.grey  ,
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
        ),
      ],
    ),
  );

}
