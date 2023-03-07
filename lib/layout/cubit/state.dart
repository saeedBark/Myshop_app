import 'package:my_shop_app/models/changeFavorit.dart';

abstract class MyshopState{}

class MyshopintitalztionState extends MyshopState{}

class MyshopchangBottomState extends MyshopState{}
///////////Get Home ///////
class MyshopLoadingGetDataHomeState extends MyshopState{}

class MyshopSuccessGetDataHomeState extends MyshopState{}

class MyshopErrorGetDataHomeState extends MyshopState{}

class MyshopSuccessGetDataCategoryState  extends MyshopState{}

class MyshopErrorGetDataCategoryState  extends MyshopState{}

class MyshopChangeFavoriteState extends MyshopState{}

class MyshopSuccessChangeFavoriteState  extends MyshopState{
   late ChangeFavoritModel model;

  MyshopSuccessChangeFavoriteState(this.model);
}

class MyshopErrorChangeFavoriteState  extends MyshopState{}

class MyshopLoadingGetFavoritesDataState  extends MyshopState{}

class MyshopSuccessGetFavoritesDataState  extends MyshopState{}

class MyshopErrorGetFavoritesDataState  extends MyshopState{}

class MyshopLoadingUpdateUserState extends MyshopState{}

class MyshopSuccessUpdateUserState extends MyshopState{}

class MyshopErrorUpdateUserState extends MyshopState{}

class MyshopLoadingGetProfileDataState extends MyshopState{}

class MyshopSuccessGetProfileDataState extends MyshopState{}

class MyshopErrorGetProfileDataState extends MyshopState{}