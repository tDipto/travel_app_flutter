import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/tabs/loginPage.dart';
import 'package:travel_app/tabs/userForm.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    bool _obscureText = true;
    bool loading = false;

    signUp() async {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        var authCredential = credential.user;
        print(authCredential!.uid);
        if (authCredential.uid.isNotEmpty) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => UserForm()));
          setState(() {
            loading = true;
          });
        } else {
          Fluttertoast.showToast(msg: "Something Wrong");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "The account already exists for that email.");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "err");
      }
    }

    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.light,
                        color: Colors.transparent,
                      ),
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Join Us!",
                          style:
                              TextStyle(fontSize: 22.sp, color: Colors.amber),
                        ),
                        Text(
                          "Glad to see you back my buddy.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFBBBBBB),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 48.h,
                        //       width: 41.w,
                        //       decoration: BoxDecoration(
                        //           color: Colors.amber,
                        //           borderRadius: BorderRadius.circular(12.r)),
                        //       child: Center(
                        //         child: Icon(
                        //           Icons.person,
                        //           color: Colors.white,
                        //           size: 20.w,
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     Expanded(
                        //       child: TextField(
                        //         // controller: _emailController,
                        //         decoration: InputDecoration(
                        //           // hintText: "thed9954@gmail.com",
                        //           hintStyle: TextStyle(
                        //             fontSize: 14.sp,
                        //             color: const Color(0xFF414041),
                        //           ),
                        //           labelText: 'Name',
                        //           labelStyle: TextStyle(
                        //             fontSize: 15.sp,
                        //             color: Colors.amber,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  // hintText: "thed9954@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF414041),
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                // obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "password must be 6 character",
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.amber,
                                  ),
                                  // suffixIcon: _obscureText == true
                                  //     ? IconButton(
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             _obscureText = false;
                                  //           });
                                  //         },
                                  //         icon: Icon(
                                  //           Icons.remove_red_eye,
                                  //           size: 20.w,
                                  //         ))
                                  //     : IconButton(
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             _obscureText = true;
                                  //           });
                                  //         },
                                  //         icon: Icon(
                                  //           Icons.visibility_off,
                                  //           size: 20.w,
                                  //         )),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        // elevated button
                        loading
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: 1.sw,
                                height: 56.h,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // setState(() {
                                    //   loading = true;
                                    // });
                                    signUp();
                                  },
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber,
                                    elevation: 3,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Have an account?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                " Sign In",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
