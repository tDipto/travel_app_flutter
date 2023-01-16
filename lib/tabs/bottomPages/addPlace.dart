import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String imageUrl = '';

  List<String> divison = [
    "ঢাকা",
    "চট্টগ্রাম",
    "রাজশাহী",
    "খুলনা",
    "বরিশাল",
    "ময়মনসিংহ",
    "রংপুর",
    "সিলেট"
  ];
  List<String> Dhaka = [
    "কিশোরগঞ্জ",
    "গাজীপুর",
    "টাঙ্গাইল",
    "ফরিদপুর",
    "নারায়ণগঞ্জ",
    "নরসিংদী",
    "মুন্সীগঞ্জ",
    "ঢাকা"
  ];
  List<String> Chittagong = [
    "কক্সবাজার",
    "ফেনী",
    "চাঁদপুর",
    "ব্রাহ্মণবাড়িয়া",
    "বান্দরবান",
    "রাঙ্গামাটি",
    "খাগড়াছড়ি",
    "চট্টগ্রাম"
  ];
  List<String> Rajshahi = [
    "বগুড়া",
    "চাপাইনবাবগঞ্জ",
    "জয়পুরহাট",
    "নওগাঁ",
    "নাটোর",
    "রাজশাহী",
    "পাবনা",
    "সিরাজগঞ্জ"
  ];
  List<String> Khulna = [
    "কুষ্টিয়া",
    "চুয়াডাঙ্গা",
    "যশোর",
    "সাতক্ষীরা",
    "বাগেরহাট",
    "মাগুরা",
    "খুলনা"
  ];
  List<String> Barisal = [
    "বরগুনা",
    "ভোলা",
    "ঝালকাঠি",
    "পাটুয়াখালি",
    "পিরোজপুর",
    "বরিশাল"
  ];
  List<String> Mymensingh = [
    "নেত্রকোনা",
    "জামালপুর",
    "শেরপুর",
    "ময়মনসিংহ",
  ];
  List<String> Rangpur = [
    "দিনাজপুর",
    "গাইবান্ধা",
    "কুড়িগ্রাম",
    "লালমনিরহাট",
    "পঞ্চগড়",
    "ঠাকুরগাঁও",
    "রংপুর"
  ];
  List<String> Sylhet = ["হবিগঞ্জ", "মৌলভীবাজার", "সুনামগঞ্জ", "সিলেট"];

  bool loading = false;
  bool dhaka = false;
  bool chittagong = false;
  bool rajshahi = false;
  bool mymensingh = false;
  bool barisal = false;
  bool rangpur = false;
  bool sylhet = false;
  bool khulna = false;

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
      "img": imageUrl
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
                  "নতুন জায়গা সংযুক্ত করুন",
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
                // const Text(
                //   "আপনার তথ্য সংরক্ষিত থাকবে",
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: Color(0xFFBBBBBB),
                //   ),
                // ),
                IconButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print('${file?.path}');

                    if (file == null) return;
                    //Import dart:core
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('addPlaceImages');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file!.path));
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      // print(imageUrl);
                    } catch (error) {
                      //Some error occurred
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                ),

                const SizedBox(
                  height: 15,
                ),
                myTextField(
                    "জায়গার নাম", TextInputType.text, _placeNameController),
                myTextField(
                    "বর্ণনা", TextInputType.text, _descriptionController),
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
                myTextField("রোডম্যাপ", TextInputType.text, _roadmapController),
                TextField(
                  controller: _divisonController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "বিভাগ",
                    prefixIcon: DropdownButton<String>(
                      items: divison.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _divisonController.text = value;
                              // Text(value);
                              if (_divisonController.text == "ঢাকা") {
                                dhaka = true;
                                chittagong = false;
                                rajshahi = false;
                                khulna = false;
                                barisal = false;
                                rangpur = false;
                                mymensingh = false;
                                sylhet = false;
                              } else if (_divisonController.text ==
                                  "চট্টগ্রাম") {
                                dhaka = false;
                                chittagong = true;
                                rajshahi = false;
                                khulna = false;
                                barisal = false;
                                rangpur = false;
                                mymensingh = false;
                                sylhet = false;
                              } else if (_divisonController.text == "রাজশাহী") {
                                dhaka = false;
                                chittagong = false;
                                rajshahi = true;
                                khulna = false;
                                barisal = false;
                                rangpur = false;
                                mymensingh = false;
                                sylhet = false;
                              } else if (_divisonController.text == "রংপুর") {
                                dhaka = false;
                                chittagong = false;
                                rajshahi = false;
                                khulna = false;
                                barisal = false;
                                rangpur = true;
                                mymensingh = false;
                                sylhet = false;
                              } else if (_divisonController.text ==
                                  "ময়মনসিংহ") {
                                dhaka = false;
                                chittagong = false;
                                rajshahi = false;
                                khulna = false;
                                barisal = false;
                                rangpur = false;
                                mymensingh = true;
                                sylhet = false;
                              } else if (_divisonController.text == "খুলনা") {
                                dhaka = false;
                                chittagong = false;
                                rajshahi = false;
                                khulna = true;
                                barisal = false;
                                rangpur = false;
                                mymensingh = false;
                                sylhet = false;
                              } else if (_divisonController.text == "বরিশাল") {
                                dhaka = false;
                                chittagong = false;
                                rajshahi = false;
                                khulna = false;
                                barisal = true;
                                rangpur = false;
                                mymensingh = false;
                                sylhet = false;
                              } else if (_divisonController.text == "সিলেট") {
                                dhaka = false;
                                chittagong = false;
                                rajshahi = false;
                                khulna = false;
                                barisal = false;
                                rangpur = false;
                                mymensingh = false;
                                sylhet = true;
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
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
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
                !chittagong
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Chittagong.map((String value) {
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
                !rajshahi
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Rajshahi.map((String value) {
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
                !mymensingh
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Mymensingh.map((String value) {
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
                !khulna
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Khulna.map((String value) {
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
                !rangpur
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Rangpur.map((String value) {
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
                !barisal
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Barisal.map((String value) {
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
                !sylhet
                    ? Text('')
                    : TextField(
                        controller: _zillacontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "জেলা",
                          prefixIcon: DropdownButton<String>(
                            items: Sylhet.map((String value) {
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

                // image

                // elevated button
                loading
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: customButton("Submit", () async {
                          if (imageUrl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please upload an image')));

                            return;
                          }
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
