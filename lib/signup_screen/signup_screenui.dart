import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramreelclone/home_screen/home_screen_ui.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/signup_screen/signup_function.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;

  // bool isLoading = true;
  void onCreateAccount() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      debugPrint("meee");
      setState(() {
        isLoading = true;
      });
      bool isAccountCreatedSucessfully = await SignupFunction.createAccount(
          email.text.trim(), password.text.trim());
      // final isAccountCreatedSucessfully = await signUp();
      if (isAccountCreatedSucessfully) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
        print("Account Created Sucessfully");
      } else {
        print("Something went wrong");
      }
      setState(() {
        isLoading = false;
      });
    }
    // signUp();
    debugPrint("nnnnn");
  }

  // Future signUp() async {
  //   // showCupertinoDialog(context: context, builder: builder)
  //   try {
  //     debugPrint("sign");
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     debugPrint("no sign");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Instagram",
                    style: TextStyle(
                      fontSize: 38.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // customTextField("Email", email),
                  // customTextField("Password", password),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                          labelText: "Email",
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          border: OutlineInputBorder(),
                        )),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                        labelText: "Password",
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customButton(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )),
                ],
              ),
            ),
          );
  }

  Widget customButton() {
    return InkWell(
      onTap: onCreateAccount,
      child: Container(
        height: 40.h,
        width: 315.w,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          "Create Account",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: onCreateAccount,
    //   child: Container(
    //     height: 40.h,
    //     width: 315.w,
    //     color: Colors.blue,
    //     alignment: Alignment.center,
    //     child:Text("Create Account",style: TextStyle(color: Colors.white,fontSize: 17.sp,fontWeight: FontWeight.w500),),
    //   ),
    //
    // );
  }

// Widget customTextField(String hintText, TextEditingController controller) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//     child: TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(),
//       ),
//     ),
//   );
// }
}
