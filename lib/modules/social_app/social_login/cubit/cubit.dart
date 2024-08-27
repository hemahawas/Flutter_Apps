import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/social_app/social_login/cubit/state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }
}
