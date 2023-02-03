import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/mainzillapage.dart';

class DivisionPage extends StatefulWidget {
  //const DivisionPage({Key? key}) : super(key: key);
  var _divisons;
  DivisionPage(this._divisons);
  //print(this._divisons);

  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  List<String> currentdivison = [];
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

  // fetchDivision1()async{
  //   var _firestoreInstance = FirebaseFirestore.instance;
  //   QuerySnapshot qn =
  //       await _firestoreInstance.collection("ফরিদপুর").get();
  //       setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       _divisions.add(
  //        {
  //         "description": qn.docs[i]["description"],
  //         "divison": qn.docs[i]["divison"],
  //         "img": qn.docs[i]["img"],
  //         "placeName": qn.docs[i]["placeName"],
  //         "roadmap": qn.docs[i]["roadmap"],
  //         "zilla": qn.docs[i]["zilla"],
  //        }

  //       );
  //     }
  //   });

  //   return qn.docs;
  // }

  @override
  void initState() {
    // fetchDivision1();
    // fetchProducts();
    checkdivision(widget._divisons);
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    //print(widget._divisons);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget._divisons),
          ),
          body: (Center(
                  child: ListView.builder(
                      itemCount: currentdivison.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ListTile(
                            title: Text(currentdivison[index]),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MyzillaPage(currentdivison[index]))),
                        );
                      }))

              //mainAxisAlignment: MainAxisAlignment.center,

              // if (widget._divisons == "চট্টগ্রাম") ...[
              //   Column(children: [
              //   Expanded(
              //   child: Center(child:
              //   ListView.builder(
              //     itemCount: Chittagong.length,
              //     itemBuilder: (context,index){
              //       return InkWell(
              //         child: ListTile(
              //           title: Text(Chittagong[index]),
              //         ),
              //         onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MyzillaPage(Chittagong[index]))),
              //       );
              //     }
              //   )
              //   )
              //   )
              //   ])
              // ],

              //   Column(
              // //mainAxisAlignment: MainAxisAlignment.center,
              // children: [
              //   //if (widget._divisons == "ঢাকা") ...[
              //     Column(children: [
              //       Expanded(
              //           child: Center(child:
              //     ListView.builder(
              //       itemCount: _Dhaka.length,
              //       itemBuilder: (context,index){
              //         return InkWell(
              //           child: ListTile(
              //             title: Text(_Dhaka[index]),
              //           ),
              //           onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MyzillaPage(_Dhaka[index]))),
              //         );
              //       }
              //     )
              //     )
              //               )
              //     ])
              //   ],
              // if (widget._divisons=="চট্টগ্রাম") ...[
              //     //   Column(children: [
              //     //       Expanded(
              //     //         child: GridView.builder(
              //     //           scrollDirection: Axis.horizontal,
              //     //           itemCount: Chittagong.length,
              //     //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //     //           itemBuilder: (_, index){
              //     //           return GestureDetector(
              //     //             onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MyzillaPage(Chittagong[index]))),
              //     //             child: Card(
              //     //               elevation: 3,
              //     //               child: Column(children: [
              //     //                 Text("${Chittagong[index]}"),

              //     //               ]),
              //     //             ),
              //     //           );
              //     //         })
              //     //       )
              //     //     ])
              //     // ],
              //     // if (widget._divisons=="চট্টগ্রাম") ...[
              //     //   Column(children: [
              //     //       Expanded(
              //     //         child: GridView.builder(
              //     //           scrollDirection: Axis.horizontal,
              //     //           itemCount: Rajshahi.length,
              //     //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //     //           itemBuilder: (_, index){
              //     //           return GestureDetector(
              //     //             onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MyzillaPage(Rajshahi[index]))),
              //     //             child: Card(
              //     //               elevation: 3,
              //     //               child: Column(children: [
              //     //                 Text("${Rajshahi[index]}"),

              //     //               ]),
              //     //             ),
              //     //           );
              //     //         })
              //     //       )
              //     //     ])
              //     // ]
              //     // else ...[
              //     //   const Icon(
              //     //     Icons.comment,
              //     //     size: 100,
              //     //     color: Colors.black,
              //     //   )
              //     // ]
              //   ],
              // )
              //)
              )),
    );
  }
}
