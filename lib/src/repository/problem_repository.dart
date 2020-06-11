import 'package:bestaid/src/models/problems.dart';
import 'package:bestaid/src/providers/problem_provider.dart';

class ProblemRepository {
  static Future<ProblemResponse> getProblems() {
    return ProblemProvider.getProblems();
  }

  static Future<dynamic> postDataToProblem(Map postData) async {
    return ProblemProvider.postDataToProblem(postData);
  }

  static Future<dynamic> postDataToProblemDiscussion(
      int postId, Map postData) async {
    return ProblemProvider.postDataToProblemDiscussion(postId, postData);
  }

  static Future<dynamic> getDiscussions(int postId) async {
    return ProblemProvider.getDiscussions(postId);
  }

  static Future<dynamic> deleteDataFromCart(Map postData) async {
    return ProblemProvider.deleteDataFromProblems(postData);
  }

  static Future<dynamic> getOpenProblems() async {
    return ProblemProvider.getOpenProblems();
  }
}
