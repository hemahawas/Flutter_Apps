import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/models/shop_app/categories_model.dart';
import 'package:my_project/models/shop_app/change_favorites_model.dart';
import 'package:my_project/models/shop_app/favorites_model.dart';
import 'package:my_project/models/shop_app/home_model.dart';
import 'package:my_project/models/shop_app/login_model.dart';
import 'package:my_project/models/shop_app/search_model.dart';
import 'package:my_project/modules/shop_app/categories/categories_screen.dart';
import 'package:my_project/modules/shop_app/favorites/favorites_screen.dart';
import 'package:my_project/modules/shop_app/products/products_screen.dart';
import 'package:my_project/modules/shop_app/settings/settings_screen.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/network/end_points.dart';
import 'package:my_project/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);


  late ShopLoginModel loginModel;

  bool isNotShown = true;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
      path: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.toString());
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates());
    });
  }

  void changePasswordVisibility(){
    isNotShown = !isNotShown;
    emit(ShopLoginChangePasswordVisibilityStates());
  }

  int currentIndex = 0;

  List<Widget> shopScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  bool homeModelUploaded = false;
  Map<int,bool> isBlur = {
    11: true,
    12: true,
    17: true,
    19: false,
    23: true,
    24: true,
    26: false,
    27: false,
    28: false,
    29: true,
  };

  Map<int, bool> favorites = {};

  void getHomeData() async {
    emit(ShopLoadingHomeDataState());

    await DioHelper.getData(path: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);


      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      homeModelUploaded = true;
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  bool categoriesUploaded = false;

  void getCategories() async {
    emit(ShopLoadingCategoriesState());
    await DioHelper.getData(path: GET_CATEGORIES, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      categoriesModel?.data.data.elementAt(2).image = 'https://th.bing.com/th/id/OIP.E-CLtMLAwhAhFx9cEMWywwHaHa?rs=1&pid=ImgDetMain';
      categoriesModel?.data.data.elementAt(3).image = 'https://th.bing.com/th/id/OIP.6rW5QYy0Rvs3RR8EVzIURwAAAA?rs=1&pid=ImgDetMain';
      categoriesModel?.data.data.elementAt(4).image = 'https://cdn-icons-png.flaticon.com/512/10365/10365636.png';

      categoriesUploaded = true;
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      path: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(model: changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;


  void getFavorites() async {
    emit(ShopLoadingGetFavoritesState());
    await DioHelper.getData(path: FAVORITES, lang: 'en', token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() async {
    emit(ShopLoadingUserState());
    await DioHelper.getData(path: PROFILE, lang: 'en', token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel?.data?.token);
      emit(ShopSuccessUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserState());
    });
  }

  void putUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      path: UPDATE_PROFILE,
      lang: 'en',
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoadingUpdateUserState());
    });
  }

  SearchModel? searchModel;

  void searchData(String text) {
    emit(ShopLoadingSearchState());
    DioHelper.postData(
      path: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(ShopSuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorSearchState());
    });
  }

  Map<ProductModel, int> selectedItems = {};

  void addItem(ProductModel  item){
    if(!selectedItems.containsKey(item)) {
      selectedItems[item] = 1;
      emit(ShopAddItemSuccessState());
    }
    else{
      selectedItems[item] = 1 + selectedItems[item]!;
      emit(ShopIncrementItemSuccessState());
    }
  }

  void removeItem(ProductModel  item){
    if(selectedItems.containsKey(item)) {
      selectedItems.remove(item);
    }
    emit(ShopRemoveItemSuccessState());
  }
  void decrementItem(ProductModel  item){
    if(selectedItems.containsKey(item)) {
      selectedItems[item] = selectedItems[item]! - 1;
    }
    if(selectedItems[item] == 0) {
      selectedItems.remove(item);
    }

    emit(ShopDecrementItemSuccessState());
  }

  double getTotalPrice(){
    double? sum = 0;
    for( var item in selectedItems.entries){
      sum = (sum! +  item.key.price * item.value) as double?;
    }
    return sum!;
  }
}
