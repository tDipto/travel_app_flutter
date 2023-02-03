import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/placeshow.dart';

class MyzillaPage extends StatefulWidget {
  //const MyzillaPage({Key? key}) : super(key: key);
  var _zilla;
  MyzillaPage(this._zilla);

  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<MyzillaPage> {
  List _divisions = [];

  fetchDivision1() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection(widget._zilla).get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _divisions.add({
          "description": qn.docs[i]["description"],
          "divison": qn.docs[i]["divison"],
          "img": qn.docs[i]["img"],
          "placeName": qn.docs[i]["placeName"],
          "roadmap": qn.docs[i]["roadmap"],
          "zilla": qn.docs[i]["zilla"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchDivision1();
    // fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._zilla),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _divisions.length,
                  //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Placeshow(_divisions[index]))),
                      child: Card(
                        elevation: 3,
                        child: Column(children: [
                          Image.network(_divisions[index]["img"]),
                          Text("${_divisions[index]["placeName"]}"),
                          Text("${_divisions[index]["description"]}"),
                          Text("${_divisions[index]["roadmap"]}"),
                        ]),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
