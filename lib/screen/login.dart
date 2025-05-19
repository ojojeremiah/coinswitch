import 'package:coinswitch/controller/firebase.dart';
import 'package:coinswitch/screen/createAccount.dart';
import 'package:coinswitch/screen/home.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _confirmVisible = true;
  // bool task = false;

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.sizeOf(context).width / 26;
    double inputBarLength = MediaQuery.sizeOf(context).width / 70;
    double emailAndPasswordIconSize = MediaQuery.sizeOf(context).width / 16;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            "Login to Your Account",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  "COIN",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "SWITCH",
                  style: TextStyle(
                      color: AppColors.brandColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.email_outlined,
                                size: emailAndPasswordIconSize),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text("Email",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize)))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: inputBarLength, right: inputBarLength),
                        width: ScreenUtil().setWidth(350),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _email,
                          onSaved: (s) {
                            _email.text = s!;
                          },
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Email Required";
                            }
                            return null;
                          },
                          style: const TextStyle(
                            height: 1,
                            wordSpacing: 2,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'aishannor41@gmail.com',
                            filled: true,
                            fillColor: AppColors.primaryColor,
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: emailAndPasswordIconSize,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize),
                                ))
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: inputBarLength, right: inputBarLength),
                            width: ScreenUtil().setWidth(350),
                            decoration: const BoxDecoration(),
                            margin: const EdgeInsets.only(top: 10, left: 5),
                            child: TextFormField(
                              onSaved: (s) {
                                _password.text = s!;
                              },
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Password Required";
                                }
                                return null;
                              },
                              obscureText: _confirmVisible,
                              controller: _password,
                              style: const TextStyle(
                                height: 1,
                                wordSpacing: 2,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: 'Password',
                                filled: true,
                                fillColor: AppColors.primaryColor,
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.8,
                                  top: MediaQuery.sizeOf(context).width / 20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _confirmVisible = !_confirmVisible;
                                  });
                                },
                                child: Icon(
                                  _confirmVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.backgroundColor,
                                ),
                              ))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.sizeOf(context).width / 2),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot password ?",
                                style: TextStyle(color: AppColors.brandColor),
                              ))),
                      Container(
                        width: ScreenUtil().setWidth(330),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                            color: AppColors.brandColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Obx(
                          () => TextButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (_email.text.isEmpty ||
                                      _password.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Fill Required fields')));
                                  }
                                  // Get.to( AccountValidation());
                                } else {
                                  // firebaseController.signin(
                                  //     _email.text, _password.text);
                                }
                                Get.to(const Home_Screen());
                              },
                              child: const Text(
                                      "Log In",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 18),
                                    )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(
                                          204, 204, 204, 1)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                      height: 20, "assets/svg/facebook.svg")),
                            ),
                            Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(
                                          204, 204, 204, 1)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: IconButton(
                                  onPressed: () {
                                    // firebaseController.googleSignIn();
                                  },
                                  icon: SvgPicture.asset(
                                      "assets/svg/google.svg")),
                            ),
                            Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(
                                          204, 204, 204, 1)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    height: 25,
                                    "assets/svg/apple.svg",
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).width * 0.2),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 85),
                                child: const Text(
                                  "Don't have an account?",
                                  style:
                                      TextStyle(color: AppColors.primaryColor),
                                )),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const CreateAccount());
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(color: AppColors.brandColor),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
