import 'package:coinswitch/service/firebase_auth.dart';
import 'package:coinswitch/service/storage_service.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FirebaseRepo {
  final FireBaseAuthService fireBaseAuthService = FireBaseAuthService();
  // final Response response = Response();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> siginInwithEmailAndPassword(
      String email, String password) async {
    try {
      User? user = await fireBaseAuthService.siginInwithEmailAndPassword(
          email, password);
      if (user != null) {
        await StorageService().setAuthenticated(await user.getIdToken(), user);
      }
    } catch (e) {
      null;
    }
    return null;
  }

  Future<User?> signup(String userEmail, dynamic userPassword) async {
    try {
      User? user = await fireBaseAuthService.siginupwithEmailAndPassword(
          userEmail, userPassword);

      if (user != null) {
        // await StorageService().setAuthenticated(await user.getIdToken(), user);

        print("User successfully signed in");
        // Get.to(()=>const NavBar());
      } else {
        Fluttertoast.showToast(
          msg: "Unable to Create Account",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[900],
          textColor: AppColors.primaryColor,
          fontSize: 14,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Network Connection Failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: AppColors.primaryColor,
        fontSize: 14,
      );
    }
    return null;
  }

  Future<void> googleSignIn() async {
    await fireBaseAuthService.signInWithGoogle();
  }
}
