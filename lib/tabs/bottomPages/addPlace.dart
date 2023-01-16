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

class AddPlace extends StatefulWidget {
  // const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  TextEditingController _placeNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _divisonController = TextEditingController();
  TextEditingController _roadmapController = TextEditingController();
  TextEditingController _zillacontroller = TextEditingController();

  List<String> divison = ["Dhaka", "CTG", "Raj"];
  List<String> Dhaka = ["gazi", "tongi", "savar"];
  List<String> CTG = ["feni", "comi", "noya"];
  List<String> Raj = ["jsr", "magu", "go"];

  bool loading = false;
  bool dhaka = false;
  bool ctg = false;
  bool raj = false;

  sendPlaceDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(_zillacontroller.text);
    return _collectionRef.doc(_placeNameController.text).set({
      "email": currentUser!.email,
      "placeName": _placeNameController.text,
      "description": _descriptionController.text,
      // "dob": _dobController.text,
      "divison": _divisonController.text,
      "zilla": _zillacontroller.text,
      "roadmap": _roadmapController.text,
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
                  "Place ADD ",
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
                // const Text(
                //   "আপনার তথ্য সংরক্ষিত থাকবে",
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: Color(0xFFBBBBBB),
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                myTextField(
                    "Place Name", TextInputType.text, _placeNameController),
                myTextField(
                    "description", TextInputType.text, _descriptionController),
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
                myTextField(
                    "Road Map ", TextInputType.text, _roadmapController),
                TextField(
                  controller: _divisonController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Division",
                    prefixIcon: DropdownButton<String>(
                      items: divison.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _divisonController.text = value;
                              // Text(value);
                              if (_divisonController.text == 'Dhaka') {
                                dhaka = true;
                                ctg = false;
                                raj = false;
                              } else if (_divisonController.text == 'CTG') {
                                dhaka = false;
                                ctg = true;
                                raj = false;
                              } else if (_divisonController.text == 'Raj') {
                                dhaka = false;
                                ctg = false;
                                raj = true;
                              }
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                !dhaka
                    ? Text("")
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Zilla",
                          prefixIcon: DropdownButton<String>(
                            items: Dhaka.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  setState(() {
                                    _zillacontroller.text = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                !ctg
                    ? Text("")
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Zilla",
                          prefixIcon: DropdownButton<String>(
                            items: CTG.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  setState(() {
                                    _zillacontroller.text = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                !raj
                    ? Text("")
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Zilla",
                          prefixIcon: DropdownButton<String>(
                            items: Raj.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  setState(() {
                                    _zillacontroller.text = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),

                SizedBox(
                  height: 50,
                ),

                // elevated button
                loading
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: customButton("Submit", () async {
                          setState(() {
                            loading = true;
                          });
                          sendPlaceDataToDB();
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
