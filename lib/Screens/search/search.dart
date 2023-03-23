
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/search/cubit/cubit.dart';
import 'package:my_shop_app/Screens/search/cubit/state.dart';
import 'package:my_shop_app/componets/componets.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchShopCubit(),
      child: BlocConsumer<SearchShopCubit, SearchShopState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormFile(
                      controller: searchController,
                      type: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      onsubmit: (String text) {
                        SearchShopCubit.get(context).searchProduct(text);
                      },

                      lable: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (state is SearchLoadingState) const LinearProgressIndicator(),
                    const SizedBox(
                      height: 12,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildProductItems(
                                SearchShopCubit.get(context)
                                    .model!
                                    .data!
                                    .data[index],
                                context,
                                inSearch: false),
                            separatorBuilder: (context, index) => const Divider(thickness: 1,height: 1,),
                            itemCount: SearchShopCubit.get(context)
                                .model!
                                .data!.data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
