

import 'package:bestaid/src/models/token.dart';
import 'package:bestaid/src/providers/token_provider.dart';

class TokenRepository {

  static Future<TokenResponse> getToken(Map loginInfo) {
    return TokenProvider.getToken(loginInfo);
  }
}