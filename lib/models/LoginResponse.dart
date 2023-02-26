
import 'package:stumble/models/UserDetails.dart';

class LoginResponse{
  String _accessToken;
  UserDetails _userDetails;

  LoginResponse(this._accessToken, this._userDetails);

  UserDetails get userDetails => _userDetails;

  set userDetails(UserDetails value) {
    _userDetails = value;
  }

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
  }
}