import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/models/shop_app/login_model.dart';
import 'package:my_project/modules/shop_app/shop_login/cubit/states.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/network/end_points.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';
import 'package:my_project/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

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
}
