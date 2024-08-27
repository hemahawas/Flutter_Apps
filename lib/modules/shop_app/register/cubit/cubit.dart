import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/models/shop_app/register_model.dart';
import 'package:my_project/modules/shop_app/register/cubit/states.dart';
import 'package:my_project/shared/network/end_points.dart';
import 'package:my_project/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopRegisterModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
      path: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.toString());
      registerModel = ShopRegisterModel.fromJson(value.data);

      emit(ShopRegisterSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates());
    });
  }
}
