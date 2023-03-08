import 'package:my_shop_app/models/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterChangePageState extends ShopRegisterState {}

class ShopRegisterChangePasswordShowState extends ShopRegisterState {}

/////////// userDataPost/////
class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  late UserLoginModel mod;

  ShopRegisterSuccessState(this.mod);
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String error;

  ShopRegisterErrorState(this.error);
}

///////////