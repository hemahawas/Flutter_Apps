import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/models/social_app/social_user_model.dart';
import 'package:my_project/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  //late SocialRegisterModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      cover:
          'https://th.bing.com/th/id/R.be91f45bc31d36591f2084889113fbad?rik=LHGQjU7vqaXirw&pid=ImgRaw&r=0',
      bio: 'Write your bio ...',
      image:
          'https://th.bing.com/th/id/R.be91f45bc31d36591f2084889113fbad?rik=LHGQjU7vqaXirw&pid=ImgRaw&r=0',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
