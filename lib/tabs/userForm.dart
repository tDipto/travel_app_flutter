import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomNavigation.dart';
// import 'package:travel_app/tabs/homePage.dart';

Widget myTextField(String hintText, keyBoardType, controller) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(hintText: hintText),
  );
}

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 300,
    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
        elevation: 3,
      ),
    ),
  );
}

class UserForm extends StatefulWidget {
  // const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["পুরুষ", "নারী", "অন্যান্য"];
  bool loading = false;

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name": _nameController.text,
      "phone": _phoneController.text,
      "email": currentUser.email,
      // "dob": _dobController.text,
      "gender": _genderController.text,
      "age": _ageController.text,
      "admin": "no"
    }).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => BottomNavigation()));
      setState(() {
        loading = false;
      });
    }).catchError(
        (error) => print("কিছু সমস্যা হয়েছে, পুনরায় চেষ্টা করুন $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "সাবমিট করুন ",
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
                const Text(
                  "আপনার তথ্য সংরক্ষিত থাকবে",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                myTextField("আপনার নাম", TextInputType.text, _nameController),
                myTextField(
                    "মোবাইল নাম্বার", TextInputType.number, _phoneController),
                // TextField(
                //   controller: _dobController,
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     hintText: "date of birth",
                //     // suffixIcon: IconButton(
                //     //   onPressed: () => _selectDateFromPicker(context),
                //     //   icon: Icon(Icons.calendar_today_outlined),
                //     // ),
                //   ),
                // ),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "লিঙ্গ নির্ধারণ করুন",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                myTextField("আপনার বয়স ", TextInputType.number, _ageController),

                SizedBox(
                  height: 50,
                ),

                // elevated button
                loading
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: customButton("চালিয়ে যান", () async {
                          if (_nameController.text == '' ||
                              _phoneController.text == '' ||
                              _genderController.text == '' ||
                              _ageController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Fill the Fields')));

                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          sendUserDataToDB();
                          // setState(() {
                          //   loading = false;
                          // });
                        }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
