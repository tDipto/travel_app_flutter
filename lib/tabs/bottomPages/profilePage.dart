import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/loginPage.dart';

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 200,
    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.redAccent,
        elevation: 3,
      ),
    ),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List _profile = [];
  bool loading = true;

  fetchProfile() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // final Firestore _firestore = Firestore.instance;

    var currentUser = _auth.currentUser;
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await _firestoreInstance.collection('users-form-data').get();
    setState(() {
      print("object");

      for (int i = 0; i < qn.docs.length; i++) {
        print(qn.docs[i]["email"]);
        print(currentUser!.email);
        if (qn.docs[i]["email"] == currentUser!.email) {
          _profile.add({
            "age": qn.docs[i]["age"],
            "gender": qn.docs[i]["gender"],
            "name": qn.docs[i]["name"],
            "phone": qn.docs[i]["phone"],
            "email": qn.docs[i]["email"],
          });
          setState(() {
            loading = false;
          });
        }
      }
    });
    print(_profile);

    return qn.docs;
  }

  @override
  void initState() {
    fetchProfile();
    print(_profile);
    // setState(() {
    //   loading = false;
    // });
    // fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('User Details'),
      //   // backgroundColor: Color.fromARGB(0, 17, 5, 5),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.exit_to_app),
      //       onPressed: () {
      //         // handle logout here
      //       },
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                // key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _profile[0]["name"],
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      initialValue: _profile[0]["email"],
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      initialValue: _profile[0]["phone"],
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customButton("Log Out", () async {
                      // _uploadImage();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));

                      // setState(() {
                      //   loading = false;
                      // });
                    }),
                  ],
                ),
              ),
      ),
    );
  }
}
