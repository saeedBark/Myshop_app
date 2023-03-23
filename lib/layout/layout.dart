
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/search/search.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/widget/navigator.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyshopCubit, MyshopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MyshopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Shop'),
            actions: [
              IconButton(onPressed: (){
                navigatorAndReplace(context, SearchScreen());
              }, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavigat,
            onTap: (index) {
              cubit.changBottom(index);
            },
          ),
        );
      },
    );
  }
}
