import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/register/cubit/state.dart';
import 'package:my_shop_app/models/login_model.dart';
import 'package:my_shop_app/network/dio_api/dioApi.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changPasswordShow() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordShowState());
  }

  late UserLoginModel model;
  void userLogin({
    required email,
    required password,
    required phone,
    required name,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      model = UserLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
