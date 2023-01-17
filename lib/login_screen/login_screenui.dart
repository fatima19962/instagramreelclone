import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramreelclone/home_screen/home_screen_ui.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/login_screen/login_function.dart';
import 'package:instagramreelclone/signup_screen/signup_screenui.dart';

class LoginScreenUI extends StatefulWidget {
  const LoginScreenUI({super.key});

  @override
  State<LoginScreenUI> createState() => _LoginScreenUIState();
}

class _LoginScreenUIState extends State<LoginScreenUI> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLoading = false;

  void onLogin() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      bool isLoginSucessfull =
          await LoginFunctions.login(email.text.trim(), password.text.trim());
      if (isLoginSucessfull) {
        print("login sucessfull");
        // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else {
        print("something went wrong");
      }
      setState(() {
        isLoading = false;
      });
    }
    debugPrint("nnnnn");
  }

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
                  // SizedBox(
                  //   height: 20.0,
                  //   child: TextFormField(
                  //
                  //       controller: email,
                  //       decoration: InputDecoration(
                  //         // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                  //         labelText: "Email",
                  //         isDense: true,
                  //         contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //       )
                  //   ),
                  // ),
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
                  // TextFormField(
                  //     controller: email,
                  //     decoration: InputDecoration(
                  //       // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                  //       labelText: "Email",
                  //       isDense: true,
                  //       contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //     )),
                  // TextFormField(
                  //   controller: password,
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                  //     labelText: "Password",
                  //     isDense: true,
                  //     contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
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
                    "New User?",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )),
                ],
              ),
            ),
          );
  }

  Widget customButton() {
    return InkWell(
      onTap: onLogin,
      child: Container(
        height: 40.h,
        width: 315.w,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

// Widget customTextField(String hintText, TextEditingController controller) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//     child: TextField(
//       controller: controller,
//       //add contoller if donot add return null
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(),
//       ),
//     ),
//   );
// }
}
