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
          Fluttertoast.showToast(msg: "কিছু ভুল হয়েছে, পুনরায় চেষ্টা করুন!");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "আপনার পাসওয়ার্ড অনেক দুর্বল ");
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: "এই ইমেইলে একটি একাউন্ট রয়েছে");
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
                      "রেজিস্টার করুন",
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
                          "আমাদের সাথে সংযুক্ত হউন",
                          style:
                              TextStyle(fontSize: 22.sp, color: Colors.amber),
                        ),
                        Text(
                          "আপনার পুনরায় ফিরে আসায় আমরা আনন্দিত!",
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
                                  labelText: 'ইমেইল',
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
                                  hintText:
                                      "পাসওয়ার্ড কমপক্ষে ৬ শব্দের হতে হবে",
                                  hintStyle: TextStyle(
                                    fontSize: 10.sp,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'পাসওয়ার্ড',
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
                                    if (_emailController.text == '' ||
                                        _passwordController.text == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please Fill the Fields')));

                                      return;
                                    }
                                    // setState(() {
                                    //   loading = true;
                                    // });
                                    signUp();
                                  },
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "চালিয়ে যান",
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
                              "পূর্বের একাউন্ট আছে?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                " সাইন ইন করুন",
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
