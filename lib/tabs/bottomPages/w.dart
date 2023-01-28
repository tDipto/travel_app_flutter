import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

class Placeshow extends StatefulWidget {
  var _place;
  Placeshow(this._place);

  @override
  State<Placeshow> createState() => _PlaceshowState();
}

class _PlaceshowState extends State<Placeshow> {
  TextEditingController _commentController = TextEditingController();
  bool loading = false;

  // var _place;
  // Placeshow(this._place);

  sendPlaceDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // final Firestore _firestore = Firestore.instance;

    var currentUser = _auth.currentUser;

    // FirebaseFirestore.instance
    //     .collection(_place['zilla'])
    //     .document(_place['roadmap'])
    //     .setData({"comments": _commentController});

    return FirebaseFirestore.instance
        .collection(widget._place['zilla'])
        .doc(widget._place['placeName'])
        .update({
          'comment': FieldValue.arrayUnion([
            {
              "email": currentUser!.email,
              'description': _commentController.text
            },
          ]),
        })
        .then(
          (value) => print('DONE'),
        )
        .catchError(
            (error) => print("কিছু সমস্যা হয়েছে, পুনরায় চেষ্টা করুন $error"));

    // return _collectionRef.doc(_commentController.text).set({
    //   "email": currentUser!.email,
    //   "description": _commentController.text,
    //   // "dob": _dobController.text,
    // }).then((value) {
    //   // Navigator.pushReplacement(
    //   //     context, MaterialPageRoute(builder: (_) => BottomNavigation()));
    //   // setState(() {
    //   //   loading = false;
    //   // });
    // }).catchError(
    //     (error) => print("কিছু সমস্যা হয়েছে, পুনরায় চেষ্টা করুন $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget._place['zilla']),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text(widget._place['placeName']),
              Text(widget._place['roadmap']),
              Text(widget._place['zilla']),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "কমেন্ট করুন",
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
                    // myTextField(
                    //     "জায়গার নাম", TextInputType.text, _placeNameController),
                    myTextField(
                        "বর্ণনা", TextInputType.text, _commentController),
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
                    // ),,
                    loading
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                            child: customButton("Submit", () async {
                              // setState(() {
                              //   loading = true;
                              // });
                              sendPlaceDataToDB();
                              // setState(() {
                              //   loading = false;
                              // });
                            }),
                          ),
                  ]))
            ],
          ),
        ),

        // body: Column(children: [
        //   Expanded(
        //     child: GridView.builder(
        //       scrollDirection: Axis.vertical,
        //       itemCount: _place.length,
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        //       itemBuilder: (_, index){
        //       return GestureDetector(
        //         onTap: (){},
        //         child: Card(
        //           elevation: 3,
        //           child: Column(children: [
        //             Image.network(_place[index]["img"]),
        //             Text("${_place[index]["placeName"]}"),
        //             Text("${_place[index]["roadmap"]}"),
        //             Text("${_place[index]["zilla"]}")
        //           ]),
        //         ),
        //       );
        //     })
        //   )
        // ]),
      ),
    );
  }
}
