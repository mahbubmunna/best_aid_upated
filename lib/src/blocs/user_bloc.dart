import 'package:bestaid/models/user.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final BehaviorSubject<UserResponse> _subject =
  BehaviorSubject<UserResponse>();

  getUser(var token) async {
    UserResponse response = await UserRepository.getUser();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;

}
final userBloc = UserBloc();