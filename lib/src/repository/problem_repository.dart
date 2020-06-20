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
      int postId, Map postData, String userType) async {
    return ProblemProvider.postDataToProblemDiscussion(
        postId, postData, userType);
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

  static Future<dynamic> getSolvedProblems() async {
    return ProblemProvider.getSolvedProblems();
  }

  static Future<dynamic> markAsSolved(int problemId) async {
    return ProblemProvider.markAsSolved(problemId);
  }
}
