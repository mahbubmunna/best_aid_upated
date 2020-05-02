

class ProblemResponse {
  List<Problem> posts;
  String error;

  ProblemResponse.fromJson(Map<String, dynamic> json)
      : posts = ((json['problem'] as List).map((item) => Problem.fromJson(item))).toList(),
        error = "";

  ProblemResponse.withError(String errorValue)
      : posts = List(),
        error = errorValue;
}

class Problem {
  int id;
  int status;
  String title;
  DateTime time;



  Problem.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        title = json["title"] ?? "",
        status = json["status"] ?? "",
        time = DateTime.parse(json["updated_at"] )?? DateTime.parse("");

}