abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginLoadingState extends SocialLoginState {}

class SocialLoginSuccessState extends SocialLoginState {
  late String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginState {
  late String error;

  SocialLoginErrorState(this.error);
}
