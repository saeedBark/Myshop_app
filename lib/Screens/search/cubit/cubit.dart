import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/search/cubit/state.dart';

class SearchShopCubit extends Cubit<SearchShopState> {
  SearchShopCubit() : super(SearchInitialState());

  static SearchShopCubit get(context) => BlocProvider.of(context);

  
}