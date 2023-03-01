import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginController extends GetxController{
  var _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async{

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    print(googleAuth?.accessToken?.toString());
  }
}