abstract class SocialStates {}

// System
class SocialInitialState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

// Get user
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// Get all users
class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

// Get posts
class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialGetLikesSuccessState extends SocialStates {}

class SocialGetCommentPostsSuccessState extends SocialStates {}

// New post
class SocialNewPostState extends SocialStates {}

// Profile & Cover image picked
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

// Profile & Cover image upload
class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

// Update user
class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

// Create Post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

// Post image
class SocialUploadPostImageLoadingState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

// Like post
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

// Comment post
class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}

// Send and Receive messages
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {}
