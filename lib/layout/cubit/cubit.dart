import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/category_screen.dart';
import 'package:my_shop_app/Screens/favorite_screen.dart';
import 'package:my_shop_app/Screens/products.dart';
import 'package:my_shop_app/Screens/setting_screen.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/models/category_model.dart';
import 'package:my_shop_app/models/changeFavorit.dart';
import 'package:my_shop_app/models/favorite_model.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/models/login_model.dart';
import 'package:my_shop_app/network/dio_api/dioApi.dart';

class MyshopCubit extends Cubit<MyshopState> {
  MyshopCubit() : super(MyshopintitalztionState());

  static MyshopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screen =  [
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

  Map<int, bool> favorits = {};
  HomeData? homemodel;
  void getDataHome() {
    emit(MyshopLoadingGetDataHomeState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homemodel = HomeData.fromJson(value.data);
      homemodel!.data!.products.forEach((element) {
        favorits.addAll({
          element.id!: element.in_favorites!,
        });
      });
      print(favorits);
      // print(homemodel!.status);
      // print(homemodel!.data!.products[0].name);
      emit(MyshopSuccessGetDataHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(MyshopErrorGetDataHomeState());
    });
  }

  CategoryModel? categorymodel;
  void getDataCategory() {
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categorymodel = CategoryModel.fromJson(value.data);
      // print(categorymodel!.data!.current_page);
      // print(categorymodel!.data!.data[2].image);
      emit(MyshopSuccessGetDataCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(MyshopErrorGetDataCategoryState());
    });
  }

  late ChangeFavoritModel changeFavoritModel;
  void changFavorite( int product_id) {
    favorits[product_id] = !favorits[product_id]!;
    emit(MyshopChangeFavoriteState());
    DioHelper.postData(url: 'favorites', token: token, data: {
      'product_id': product_id,
    }).then((value) {
      changeFavoritModel = ChangeFavoritModel.fromJson(value.data);
      // print(changeFavoritModel.status);
      // print(changeFavoritModel.message);
      if (!changeFavoritModel.status!) {
        favorits[product_id] = !favorits[product_id]!;
      }else{
        getFavorites();
      }
      emit(MyshopSuccessChangeFavoriteState(changeFavoritModel));
    }).catchError((error) {
      favorits[product_id] = !favorits[product_id]!;
      print(error.toString());
      emit(MyshopErrorChangeFavoriteState());
    });
  }

  late FavoritesModel favoritesModel;
  void getFavorites() {
    emit(MyshopLoadingGetFavoritesDataState());

    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      // print(favoritesModel.data!.data![0].product!.name);
      // print(favoritesModel.data!.data![0].product!.price);
      emit(MyshopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(MyshopErrorGetFavoritesDataState());
    });
  }
   UserLoginModel? updatemodel;
  void updateUser({
  required String name,
    required String email,
    required String phone,

}) {
    emit(MyshopLoadingUpdateUserState());

    DioHelper.putData(url: 'update-profile',data: {
      'name':name,
      'email':email,
      'phone':phone,
    }, token: token).then((value) {
      updatemodel = UserLoginModel.fromJson(value.data);

      // print(favoritesModel.data!.data![0].product!.name);
      // print(favoritesModel.data!.data![0].product!.price);
      emit(MyshopSuccessUpdateUserState());
    }).catchError((error) {
      print(error.toString());
      emit(MyshopErrorUpdateUserState());
    });
  }
  UserLoginModel? update;
  void getUserData() {
    emit(MyshopLoadingGetProfileDataState());

    DioHelper.getData(url: 'profile', token: token).then((value) {
      update = UserLoginModel.fromJson(value.data);

      // print(favoritesModel.data!.data![0].product!.name);
      // print(favoritesModel.data!.data![0].product!.price);
      emit(MyshopSuccessGetProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(MyshopErrorGetProfileDataState());
    });
  }

}
