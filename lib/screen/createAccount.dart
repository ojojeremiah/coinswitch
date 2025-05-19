import 'package:coinswitch/controller/firebase.dart';
import 'package:coinswitch/screen/mnemonic.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'Login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // final FirebaseController firebaseController = Get.put(FirebaseController());
  final _formKey = GlobalKey<FormState>();
  final controllers = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  bool _confirmVisible = true;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _phoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    // double emailAndPasswordIconSize = MediaQuery.sizeOf(context).width / 16;
    // double inputBarLength = MediaQuery.sizeOf(context).width / 70;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Create Account",
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
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.8,
                                decoration: BoxDecoration(),
                                margin: const EdgeInsets.only(
                                    left: 10, top: 20, right: 10),
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
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'email',
                                    filled: true,
                                    fillColor: AppColors.primaryColor,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    // padding: EdgeInsets.only(
                                    //     left: inputBarLength, right: inputBarLength),
                                    width: width * 0.8,
                                    decoration: const BoxDecoration(),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
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
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        hintText: 'Password',
                                        filled: true,
                                        fillColor: AppColors.primaryColor,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              MediaQuery.sizeOf(context).width *
                                                  0.7,
                                          top:
                                              MediaQuery.sizeOf(context).width /
                                                  20),
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
                                // padding: EdgeInsets.only(
                                //     left: inputBarLength, right: inputBarLength),
                                width: width * 0.8,
                                decoration: const BoxDecoration(),
                                margin: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                child: TextFormField(
                                  controller: _username,
                                  onSaved: (s) {
                                    _username.text = s!;
                                  },
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "username Required";
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
                                    hintText: 'user name',
                                    filled: true,
                                    fillColor: AppColors.primaryColor,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.only(
                                //     left: inputBarLength, right: inputBarLength),
                                width: width * 0.8,
                                decoration: const BoxDecoration(),
                                margin: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                child: TextFormField(
                                  onSaved: (s) {
                                    _phoneNumber.text = s!;
                                  },
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Phone Number Required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _phoneNumber,
                                  style: const TextStyle(
                                    height: 1,
                                    wordSpacing: 2,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: 'phone number +234',
                                    // labelText: 'phone number',
                                    filled: true,
                                    fillColor: AppColors.primaryColor,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      width: ScreenUtil().setWidth(300),
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      decoration: const BoxDecoration(
                          color: AppColors.brandColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            Get.to(() => const WalletMnemonic());
                            //   firebaseController.signUp(
                            //       _email.text, _password.text);
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('Fill Required fields')),
                            //   );
                            // }
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 18),
                          )),
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
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
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
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: IconButton(
                                onPressed: () {
                                  // firebaseController.googleSignIn();
                                },
                                icon:
                                    SvgPicture.asset("assets/svg/google.svg")),
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => const LoginPage());
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(color: AppColors.brandColor),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// if (_formKey.currentState!.validate()) {
//
//   _formKey.currentState!.save();
//   // Get.to( AccountValidation());
// }else
// {ScaffoldMessenger.of(context).showSnackBar(
//   const SnackBar(content: Text('Fill Required fields')),
// );}
// createprofile(true,
//     _email.text.toString(),
//     _firstname.text.toString(),
//     _lastname.text.toString(),
//     _password.text.toString(),
//     _passwordConfirmation.text.toString(),
//     _phoneNumber.text.toString(),
//     _username.text.toString(),
//     "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=826&t=st=1679906108~exp=1679906708~hmac=59848b1ebd30cfbc20018d5723beeb247556f9d2556966c17e30d7f1236144c8",
//     sx.active,
//     sx.on,
//     "admin"
// );
