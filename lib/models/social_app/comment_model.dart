class CommentData {
  late String text;
  late String user;

  CommentData.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    user = json['user'];
  }
}
