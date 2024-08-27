import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/models/social_app/comment_model.dart';
import 'package:my_project/models/social_app/message_model.dart';
import 'package:my_project/models/social_app/post_model.dart';
import 'package:my_project/models/social_app/social_user_model.dart';
import 'package:my_project/modules/social_app/new_post/new_post_screen.dart';
import 'package:my_project/modules/social_app/users/users_screen.dart';
import 'package:my_project/modules/social_app/settings/settings_screen.dart';
import 'package:my_project/modules/social_app/chats/chats_screen.dart';
import 'package:my_project/modules/social_app/feeds/feeds_screen.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  var coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await coverPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String? profileImageUrl;

  void uploadProfileImage() {
    emit(SocialUploadProfileImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;

  void uploadCoverImage() {
    emit(SocialUploadCoverImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    String? email,
    required String phone,
    String? bio,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email ?? userModel!.email,
      phone: phone,
      uId: uId,
      bio: bio ?? 'Write your bio ...',
      cover: coverImageUrl ?? userModel!.cover,
      image: profileImageUrl ?? userModel!.image,
      isEmailVerified: false,
    );
    emit(SocialUserUpdateLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('posts').get().then((value) {
        for (var post in value.docs) {
          if (userModel!.uId == post.data()['uId']) {
            updatePost(post.id);
          }
        }
      });

      getUserData();
      getPosts();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void updatePost(String id) {
    FirebaseFirestore.instance.collection('posts').doc(id).update({
      'name': userModel!.name,
      'image': userModel!.image,
    }).then((value) {
      getPosts();
    }).catchError((error) {});
  }

  File? postImage;
  var postPicker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await postPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  String? postImageUrl;

  void uploadPostImage({
    required dateTime,
    required text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;
        createPost(
          dateTime: dateTime,
          text: text,
        );
        emit(SocialUploadPostImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImageUrl ?? '',
    );
    emit(SocialCreatePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      getPosts();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
        }).then((value) {
          emit(SocialGetLikesSuccessState());
        }).then((value) {
          element.reference.collection('comments').get().then((value) {
            List<String> data = [];

            for (var comment in value.docs) {
              data.add(comment.get('comment'));
            }
            comments.addAll({
              element.id: data,
            });
          }).then((value) {
            emit(SocialGetCommentPostsSuccessState());
          }).then((value) {
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
          }).then((value) {
            emit(SocialGetPostsSuccessState());
          });
        });
      }
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      getPosts();
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  Map<String, List<String>> comments = {};

  void commentPost(String postId, String text) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'user': userModel!.uId,
      'comment': text,
    }).then((value) {
      getPosts();
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users/').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
      }).catchError((error) {
        emit(SocialGetPostsErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialGetMessageSuccessState());
    }).catchError((error) {
      emit(SocialGetMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      print('done');
      print('messages : ${messages.length}');
      emit(SocialGetMessageSuccessState());
    });
  }
}
