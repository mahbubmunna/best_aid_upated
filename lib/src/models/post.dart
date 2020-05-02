

class PostResponse {
  List<Post> posts;
  String error;

  PostResponse.fromJson(Map<String, dynamic> json)
      : posts = ((json['posts'] as List).map((item) => Post.fromJson(item))).toList(),
        error = "";

  PostResponse.withError(String errorValue)
      : posts = List(),
        error = errorValue;
}

class Post {
  int id;
  String title;
  String body;
  DateTime time;



  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        title = json["title"] ?? "",
        body = json["body"] ?? "",
        time = DateTime.parse(json["updated_at"] )?? DateTime.parse("");

}