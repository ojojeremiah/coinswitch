// import 'package:coinswitch/repository/firebase_repo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// import '../screen/navbar.dart';
// import '../service/firebase_auth.dart';
// import '../utils/theme/app_colors.dart';
//
// class FirebaseController extends GetxController {
//   final FirebaseRepo firebaseRepo = FirebaseRepo();
//
//   var isSignin = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   void signin(String userEmail, dynamic userPassword) async {
//     String email = userEmail;
//     String password = userPassword;
//
//     User? user =
//         await firebaseRepo.siginInwithEmailAndPassword(email, password);
//
//     if (user != null) {
//       print("User successfully signed in");
//       // Get.to(()=>const NavBar());
//     } else {
//       Fluttertoast.showToast(
//         msg: "Network Connection Failed",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey[900],
//         textColor: AppColors.primaryColor,
//         fontSize: 14,
//       );
//     }
//   }
//
//   void signUp(String userEmail, dynamic userPassword) async {
//     String email = userEmail;
//     String password = userPassword;
//
//     User? user = await firebaseRepo.signup(email, password);
//
//     if (user != null) {
//       print("User successfully signed in");
//       // Get.to(()=>const NavBar());
//     } else {
//       Fluttertoast.showToast(
//         msg: "Network Connection Failed",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey[900],
//         textColor: AppColors.primaryColor,
//         fontSize: 14,
//       );
//     }
//   }
//
//   void googleSignIn() async {
//     await firebaseRepo.googleSignIn();
//   }
// }
