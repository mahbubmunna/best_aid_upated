

class DiscussionResponse {
  List<Discussion> discussions;
  String error;

  DiscussionResponse.fromJson(Map<String, dynamic> json)
      : discussions = ((json['problem']['discussion'] as List).map((item) => Discussion.fromJson(item))).toList(),
        error = "";

  DiscussionResponse.withError(String errorValue)
      : discussions = List(),
        error = errorValue;
}

class Discussion {
  int id;
  String type;
  String message;
  DateTime time;



  Discussion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        message = json["message"] ?? "",
        type = json["type"] ?? "",
        time = DateTime.parse(json["updated_at"] ) ?? DateTime.now();

}