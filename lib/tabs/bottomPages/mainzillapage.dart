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
      // print(qn.docs[0]["comment"][0]['rating']);
      for (int i = 0; i < qn.docs.length; i++) {
        List<String> descriptionComment = [];
        List<int> rating = [];
        List<String> emails = [];
        double avg = 0;
        for (int j = 0; j < qn.docs[i]["comment"]?.length; j++) {
          // print(qn.docs[i]["comment"].length);
          String temp = qn.docs[i]["comment"][j]["description"];
          descriptionComment.add(temp);
        }
        for (int j = 0; j < qn.docs[i]["comment"]?.length; j++) {
          // print(qn.docs[i]["comment"].length);
          int temp = qn.docs[i]["comment"][j]["rating"];
          avg += temp;
          rating.add(temp);
        }
        avg /= qn.docs[i]["comment"].length;
        print(avg);

        for (int j = 0; j < qn.docs[i]["comment"]?.length; j++) {
          // print(qn.docs[i]["comment"].length);
          String temp = qn.docs[i]["comment"][j]["email"];
          emails.add(temp);
        }

        // var avg_rating = qn.docs[i]["comment"].map((i) {
        //   int rating = i["rating"];
        //   return total_rating = total_rating + rating;
        // });
        avg = avg ?? 0;

        _divisions.add({
          "description": qn.docs[i]["description"],
          "divison": qn.docs[i]["divison"],
          "img": qn.docs[i]["img"],
          "placeName": qn.docs[i]["placeName"],
          "roadmap": qn.docs[i]["roadmap"],
          "zilla": qn.docs[i]["zilla"],
          "descriptionComment": descriptionComment,
          "rating": rating,
          "emails": emails,
          "avg": avg
        });
        // total_rating = 0;
        avg = 0;
      }
    });

    return qn.docs;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    fetchDivision1();
    // fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
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
                                  builder: (_) =>
                                      Placeshow(_divisions[index]))),
                          child: Card(
                            elevation: 4.0,
                            margin: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    _divisions[index]["img"],
                                    width: 300.0,
                                    height: 200.0,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${_divisions[index]["placeName"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // height: 6.5,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Container(
                                    child: Row(
                                      children: [
                                        Text("রেটিং"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Row(
                                            children: List.generate(5, (p) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  _divisions[index]['avg'] !=
                                                              null &&
                                                          _divisions[index]
                                                                  ['avg'] >
                                                              p
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.greenAccent,
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //     "${_divisions[index]["description"]?.substring(0, 20)}"),
                                  // Text("${_divisions[index]["roadmap"]}"),
                                  // Text("${_divisions[index]["rating"]}"),
                                ],
                              ),
                            ),
                          )
                          //     Card(
                          //   elevation: 3,
                          //   child: Column(children: [
                          //     Image.network(_divisions[index]["img"]),
                          //     Text("${_divisions[index]["placeName"]}"),
                          //     Text("${_divisions[index]["description"]}"),
                          //     Text("${_divisions[index]["roadmap"]}"),
                          //     Text("${_divisions[index]["rating"]}"),
                          //   ]),
                          // ),
                          );
                    }))
          ]),
        ),
      ),
    );
  }
}