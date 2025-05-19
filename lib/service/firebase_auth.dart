import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/theme/app_colors.dart';

class FireBaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> siginupwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<User?> siginInwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      null;
    }
    return null;
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await _auth.signInWithCredential(credential);
        // Get.to(()=> const NavBar(mnemonic: ,));
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "some error occured: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.brandColor,
        textColor: AppColors.primaryColor,
        fontSize: 14,
      );
    }
  }
}
