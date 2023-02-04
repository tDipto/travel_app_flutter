import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomNavigation.dart';

Widget myTextField(String hintText, keyBoardType, controller) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(hintText: hintText),
  );
}

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 150,
    height: 40,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        'কমেন্ট',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
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
  List user = [];
  List _comment = [];
  List _profile = [];
  int _selectedRating = 0;

  // fetchComment() async {
  //   var _firestoreInstance = FirebaseFirestore.instance;
  //   QuerySnapshot qn = await _firestoreInstance.collection(widget._place).get();
  //   setState(() {
  //     // print(qn.docs[0]["comment"][0]['rating']);
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       // int total_rating = 0;
  //       // var avg_rating = qn.docs[i]["comment"].map((i) {
  //       //   int rating = i["rating"];
  //       //   return total_rating = total_rating + rating;
  //       // });
  //       // if (avg_rating?.length >= 1) {
  //       //   avg_rating = int.parse(avg_rating[1]);
  //       // }
  //       // avg_rating = int.parse(avg_rating[1]);
  //       // print(avg_rating);
  //       _comment.add({
  //         "c_description": qn.docs[i]["description"],
  //         "c_email": qn.docs[i]["email"],
  //         "c_rating": qn.docs[i]["rating"],
  //         // "rating": avg_rating
  //       });
  //       // total_rating = 0;
  //     }
  //   });

  //   return qn.docs;
  // }

  fetchProfile() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // final Firestore _firestore = Firestore.instance;

    var currentUser = _auth.currentUser;
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection('users-form-data').get();
    setState(() {
      // print("object");

      for (int i = 0; i < qn.docs.length; i++) {
        // print(qn.docs[i]["email"]);
        // print(currentUser!.email);
        if (qn.docs[i]["email"] == currentUser!.email) {
          _profile.add({
            "age": qn.docs[i]["age"],
            "gender": qn.docs[i]["gender"],
            "name": qn.docs[i]["name"],
            "phone": qn.docs[i]["phone"],
            "email": qn.docs[i]["email"],
            //"comment":qn.docs[i]["comment"],
          });
          setState(() {
            loading = false;
          });
        }
      }
    });
    // print(_profile);

    return qn.docs;
  }
  // var _place;
  // Placeshow(this._place);

  sendPlaceDataToDB() async {
    print(user);
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
          // "name": _profile[0]["name"],
          "email": currentUser!.email,
          'description': _commentController.text,
          "rating": _selectedRating
        },
      ]),
    }).then(
      (value) {
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const BottomNavigation()));
        setState(() {
          loading = true;
        });
      },
    ).catchError(
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
  void initState() {
    fetchProfile();
    print(widget._place['descriptionComment']);
    print(widget._place['rating']);
    print(widget._place['emails']);

    // setState(() {
    //   loading = false;
    // });
    //fetchComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget._place['placeName']),
          backgroundColor: Colors.greenAccent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    //elevation: 50,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent[100],
                    child: Image.network(widget._place["img"]),
                  ),
                  //Text("Description of the Place",selectionColor: Colors.greenAccent,textDirection: TextDirection.ltr,),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.white,
                        child: Text(widget._place['description']),
                      ),
                    ),
                    //elevation: 50,
                    shadowColor: Colors.black,
                    color: Colors.white,
                  ),
                  // Expanded(
                  //     child: ListView.builder(
                  //   itemCount: widget._place.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return ListTile(
                  //       title: Text("${widget._place[index]['comment']}"),
                  //     );
                  //   },
                  // )),
                  //Text(widget._place['placeName'],style: TextStyle(fontSize: 25),),
                  //Image.network(widget._place["img"]),

                  //Text(widget._place['description']),
                  //Text(widget._place['zilla']),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "রোড ম্যাপ",
                    style: TextStyle(fontSize: 25, color: Colors.greenAccent),
                    textAlign: TextAlign.left,
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.white,
                        child: Text(widget._place['roadmap']),
                      ),
                    ),
                    //elevation: 50,
                    shadowColor: Colors.black,
                    color: Colors.white,
                  ),
                  //Text(widget._place['roadmap']),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "রিভিউ",
                    style: TextStyle(fontSize: 25, color: Colors.greenAccent),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget._place['descriptionComment'].length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: Icon(Icons.people),
                        title: Text(widget._place['emails'][index],style:TextStyle(fontSize: 12),),
                        subtitle: Text(
                            '${widget._place['descriptionComment'][index]}'),








                        trailing: //Text('${widget._place['rating'][index]}'),

                                           Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: List.generate(5, (p) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  size:12,
                                                  widget._place['rating'][index] !=
                                                              null &&
                                                          widget._place['rating']
                                                                  [index] >
                                                              p
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.greenAccent,
                                                ),
                                              );
                                            }),
                                          ),
                                        














                      );
                    },
                  ),
                  //Text(widget._place['descriptionComment'][0]),
                  // ListView.builder(
                  // itemCount: widget._place['descriptionComment'].length,
                  //     // scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return InkWell(
                  //         child: ListTile(
                  //           title: Text(widget._place['descriptionComment'][index]),
                  //         ),
                  //         onTap: () {}
                  //       );
                  //     }

                  // ),

                  // New comment start

//          @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: Icon(Icons.ac_unit),
//               title: Text(items[index]),
//               subtitle: Text('Subtitle for ${items[index]}'),
//               trailing: Icon(Icons.arrow_forward),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

                  // New comment end

                  Container(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "কমেন্ট করুন",
                            style: TextStyle(
                                fontSize: 22, color: Colors.greenAccent),
                          ),
                          Container(
                            child: Row(
                              children: List.generate(5, (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedRating = index + 1;
                                    });
                                  },
                                  child: Icon(
                                    _selectedRating != null &&
                                            _selectedRating > index
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.greenAccent,
                                  ),
                                );
                              }),
                            ),
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
                          // Padding(
                          //   padding: EdgeInsets.all(20.0),

                          // ),
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
                          const SizedBox(
                            height: 20,
                          ),
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
                        ]),
                  ))
                ],
              ),
            ),
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
