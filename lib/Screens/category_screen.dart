import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyshopCubit, MyshopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MyshopCubit.get(context).categorymodel!.data!.data;
        return ListView.separated(
            itemBuilder: (context, index) => builderCategoryItem(cubit[index]),
            separatorBuilder: (context, index) => const Divider(
              // thickness: 1,
              // height: 1,
            ),
            itemCount: cubit.length);
      },
    );
  }
  Widget builderCategoryItem(DataCategory model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20,),
          Text(
            model.name!,
            style: const TextStyle(fontSize: 24),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
  }

