

class TokenResponse {
  final String token;
  final String error;

  TokenResponse(this.token,this.error);

  TokenResponse.fromJson(Map<String, dynamic> json)
      : token = json['access_token'],
        error = "";

  TokenResponse.withError(String errorValue)
      : token = "",
        error = errorValue;
}


