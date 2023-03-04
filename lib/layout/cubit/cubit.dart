import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/category_screen.dart';
import 'package:my_shop_app/Screens/favorite_screen.dart';
import 'package:my_shop_app/Screens/products.dart';
import 'package:my_shop_app/Screens/setting_screen.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/network/dio_api/dioApi.dart';

class MyshopCubit extends Cubit<MyshopState> {
  MyshopCubit() : super(MyshopintitalztionState());

  static MyshopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screen = const [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigat = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];
  void changBottom(int index) {
    currentIndex = index;
    emit(MyshopchangBottomState());
  }

   HomeData? homemodel;
  void getDataHome() {
    emit(MyshopLoadingGetDataHomeState());
    DioHelper.getData(url: 'home',token: token).then((value) {
      homemodel = HomeData.fromJson(value.data);
      print(homemodel!.status);
     print(homemodel!.data!.products[0].name);
      emit(MyshopSuccessGetDataHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(MyshopErrorGetDataHomeState());
    });
  }
}
