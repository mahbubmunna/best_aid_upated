import 'package:bestaid/src/models/discussion.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
import 'package:rxdart/rxdart.dart';

class DiscussionBloc {
  final BehaviorSubject<DiscussionResponse> _subject =
  BehaviorSubject<DiscussionResponse>();

  getDiscussions(var postId) async {
    DiscussionResponse response = await ProblemRepository.getDiscussions(postId);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<DiscussionResponse> get subject => _subject;

}
final discussionBloc = DiscussionBloc();