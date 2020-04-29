


import 'package:bestaid/models/token.dart';
import 'package:bestaid/providers/token_provider.dart';

class TokenRepository {

  static Future<Token> getToken(Map loginInfo) {
    return TokenProvider.getToken(loginInfo);
  }
}