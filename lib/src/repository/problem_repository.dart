



import 'package:bestaid/src/models/problems.dart';
import 'package:bestaid/src/providers/problem_provider.dart';

class ProblemRepository{

  static Future<ProblemResponse> getProblems() {
    return ProblemProvider.getProblems();
  }

  static Future<dynamic> postDataToProblem(Map postData) async{
    return ProblemProvider.postDataToProblem(postData);
  }

  static Future<dynamic> deleteDataFromCart(Map postData) async{
    return ProblemProvider.deleteDataFromProblems(postData);
  }
}