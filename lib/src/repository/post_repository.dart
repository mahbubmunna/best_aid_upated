



import 'package:bestaid/src/models/post.dart';
import 'package:bestaid/src/providers/post_provider.dart';

class PostRepository{

  static Future<PostResponse> getPost() {
    return PostProvider.getPost();
  }

  static Future<PostResponse> getProblems() {
    return PostProvider.getPost();
  }

  static Future<dynamic> postDataToProblem(Map postData) async{
    return PostProvider.postDataToProblem(postData);
  }

  static Future<dynamic> deleteDataFromCart(Map postData) async{
    return PostProvider.deleteDataFromPost(postData);
  }
}