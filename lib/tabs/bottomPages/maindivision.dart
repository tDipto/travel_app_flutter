import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/divisionPage.dart';
import 'package:travel_app/tabs/bottomPages/placeshow.dart';

class MainDivisionPage extends StatefulWidget {
  const MainDivisionPage({Key? key}) : super(key: key);

  @override
  _MainDivisionPageState createState() => _MainDivisionPageState();
}

class _MainDivisionPageState extends State<MainDivisionPage> {
  List _mdivisions = [
    'ঢাকা',
    'চট্টগ্রাম',
    'রাজশাহী',
    "রংপুর",
    "খুলনা",
    "বরিশাল",
    "সিলেট",
    "ময়মনসিংহ"
  ];
  List<String> _mdivisions2 = [
    'Dhaka',
    'Chittagong',
    'Rajshahi',
    "Khulna",
    "Sylhet",
    "Barisal",
    "Mymensingh",
    "Rangpur"
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
  List _divisions = [];
  List<String> currentdivison = [];

  fetchDivision1() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    void checkdivision(_divisons) {
      if (_divisons == "ঢাকা") {
        currentdivison = Dhaka;
      }
      if (_divisons == "চট্টগ্রাম") {
        currentdivison = Chittagong;
      }
      if (_divisons == "রাজশাহী") {
        currentdivison = Rajshahi;
      }
      if (_divisons == "খুলনা") {
        currentdivison = Khulna;
      }
      if (_divisons == "বরিশাল") {
        currentdivison = Barisal;
      }
      if (_divisons == "ময়মনসিংহ") {
        currentdivison = Mymensingh;
      }
      if (_divisons == "রংপুর") {
        currentdivison = Rangpur;
      }
      if (_divisons == "সিলেট") {
        currentdivison = Sylhet;
      }
    }

    for (int i = 0; i < _mdivisions.length; i++) {
      checkdivision(_mdivisions[i]);
      for (int j = 0; j < currentdivison.length; j++) {
        // print(currentdivison);
        QuerySnapshot qn =
            await _firestoreInstance.collection(currentdivison[j]).get();
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
      }
    }

    // return qn.docs;
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
      body: SafeArea(
        child: (Center(
            child: Column(
          children: [
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 237, 244, 234),
                child: ListView.builder(
                    itemCount: _mdivisions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ListTile(
                          title: Text(_mdivisions[index]),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DivisionPage(_mdivisions[index]))),
                      );
                    }),
              ),
            ),
            Text('দর্শনীয় স্থান ->'),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                                  Text(
                                    "${_divisions[index]["placeName"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // height: 6.5,
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
          ],
        ))),
      ),
    ));
  }
}
