import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/search/cubit/state.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/models/search_model.dart';
import 'package:my_shop_app/network/dio_api/dioApi.dart';

class SearchShopCubit extends Cubit<SearchShopState> {
  SearchShopCubit() : super(SearchInitialState());

  static SearchShopCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void searchProduct(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: 'products/search', token: token,data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      // print(searchModel!.data!.data[0].name);
      // print(searchModel!.data!.data[0].oldPrice);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}