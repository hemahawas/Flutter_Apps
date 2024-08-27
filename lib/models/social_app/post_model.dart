class PostModel {
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? dateTime;
  String? text;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.postImage,
    required this.dateTime,
    required this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
