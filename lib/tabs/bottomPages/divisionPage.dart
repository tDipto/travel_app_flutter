import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/mainzillapage.dart';
import 'package:flutter/src/widgets/binding.dart';

class DivisionPage extends StatefulWidget {
  //const DivisionPage({Key? key}) : super(key: key);
  var _divisons;
  DivisionPage(this._divisons);
  //print(this._divisons);

  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  List <String> _Dhaka = [
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget._divisons);
    return SafeArea(
      child: Scaffold(
          body: (
            
            Center(child: 
            ListView.builder(
              itemCount: _Dhaka.length,
              itemBuilder: (context,index){
                return InkWell(
                  child: ListTile(
                    title: Text(_Dhaka[index]),
                  ),
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MyzillaPage(_Dhaka[index]))),
                );
              }
            ) 
            )
    
        
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
          )
      ),
    );
  }
}
