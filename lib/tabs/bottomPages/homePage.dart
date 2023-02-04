import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_final_fields
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  var _firestoreInstance = FirebaseFirestore.instance;
  bool loading = true;

  fetchCarouselImages() async {
    // print(_carouselImages);
    // ignore: no_leading_underscores_for_local_identifiers

    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-img").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["imgPath"],
        );
        // print("PATH" + qn.docs[i]["imgPath"]);
      }
      loading = false;
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
    fetchCarouselImages();
    // fetchProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 300.0,
              
            // ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  loading
                ? CircularProgressIndicator()
                : AspectRatio(
                    aspectRatio: 1.2,
                    child: CarouselSlider(
                        items: _carouselImages
                            .map((item) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: 3, right: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(item),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (val, carouselPageChangedReason) {
                              setState(() {
                                _dotPosition = val;
                              });
                            })),
                  ),
                  Text(
                    'ভ্রমণ পিপাসুর ভ্রমণস্থান অনুসন্ধান',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'ভ্রমণ কার না ভালো লাগে? আর এই ভ্রমণ যদি হয় কোনপ্রকার ভোগান্তি ছাড়া তখন যেন বাঁধভাঙ্গা আনন্দ-উল্লাসে মেতে উঠে আমাদের মনপ্রাণ। ভ্রমণের এই ভোগান্তিকে কমানোর জন্যই আমরা নিয়ে এসেছি আমাদের এই ট্রাভেল অ্যাপ । এখানে আপনারা পাবেন ট্রাভেল বিষয়ক যাবতীয় তথ্য যার মাধ্যমে আপনি ঘুরতে যেতেন পারবেন দেশের বিভিন্ন দর্শনীয় স্থানে । ট্রাভেল অ্যাপের পক্ষে থেকে আপনাকে স্বাগতম ।'
                        ,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromARGB(255, 243, 248, 243),
//         body: SafeArea(
//             child: Container(
//                 child: Column(children: [
//           // Padding(
//           //   padding: const EdgeInsets.only(left: 20, right: 20),
//           //   child: TextFormField(
//           //     readOnly: true,
//           //     // ignore: prefer_const_constructors
//           //     decoration: InputDecoration(
//           //       filled: true,
//           //       fillColor: Colors.white,
//           //       // ignore: prefer_const_constructors
//           //       focusedBorder: OutlineInputBorder(
//           //           borderRadius: const BorderRadius.all(Radius.circular(0)),
//           //           borderSide: const BorderSide(
//           //               color: Color.fromARGB(255, 220, 232, 243))),
//           //       enabledBorder: const OutlineInputBorder(
//           //           borderRadius: BorderRadius.all(Radius.circular(0)),
//           //           borderSide: BorderSide(color: Colors.grey)),
//           //       hintText: "জায়গা খুজুন ",
//           //       hintStyle: const TextStyle(fontSize: 15),
//           //     ),
//           //     // onTap: () => Navigator.push(
//           //     //     context, CupertinoPageRoute(builder: (_) => SearchScreen())),
//           //   ),
//           // ),
//           const SizedBox(
//             height: 10,
//           ),
//           loading
//               ? CircularProgressIndicator()
//               : AspectRatio(
//                   aspectRatio: 1.2,
//                   child: CarouselSlider(
//                       items: _carouselImages
//                           .map((item) => Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 3, right: 3),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: NetworkImage(item),
//                                           fit: BoxFit.fitWidth)),
//                                 ),
//                               ))
//                           .toList(),
//                       options: CarouselOptions(
//                           autoPlay: false,
//                           enlargeCenterPage: true,
//                           viewportFraction: 0.8,
//                           enlargeStrategy: CenterPageEnlargeStrategy.height,
//                           onPageChanged: (val, carouselPageChangedReason) {
//                             setState(() {
//                               _dotPosition = val;
//                             });
//                           })),
//                 ),
//           // SizedBox(
//           //   height: 10.h,
//           // ),
//           // DotsIndicator(
//           //   dotsCount: _carouselImages.length == 0 ? 1 : _carouselImages.length,
//           //   position: _dotPosition.toDouble(),
//           //   // ignore: prefer_const_constructors
//           //   decorator: DotsDecorator(
//           //     activeColor: Colors.lightBlueAccent,
//           //     color: Colors.greenAccent,
//           //     spacing: EdgeInsets.all(2),
//           //     activeSize: Size(8, 8),
//           //     size: Size(6, 6),
//           //   ),
//           // ),
//           SizedBox(
//             height: 00,
//           ),
//             Card(
//               elevation: 4.0,
//                             margin: EdgeInsets.all(8.0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Container(
//                         color: Colors.white,
//                         child: Text("বিশ্বের প্রতিটি প্রান্তে পর্যটন করুন এবং স্মৃতিকথা গড়ে তুলুন! আমাদের প্রয়োজনীয় ট্র্যাভেল অ্যাপ আপনাকে আপনার সম্পর্কের ট্র্যাভেল পরিকল্পনার সঙ্গে জড়িত করবে।"
                        
//                         ),
//                       ),
//                     ),
//                     //elevation: 50,
//                     shadowColor: Colors.black,
//                     color: Colors.white,
//                   ),
          
//         ]  
//       )
//       )
//       )
//       );
//   }
// }


//import 'package:carousel_pro/carousel_pro.dart';

//class HomePage extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: <Widget>[
  //         Container(
  //           height: 300.0,
            
  //         ),
  //         Container(
  //           padding: EdgeInsets.all(20.0),
  //           child: Column(
  //             children: <Widget>[
  //               loading
  //             ? CircularProgressIndicator()
  //             : AspectRatio(
  //                 aspectRatio: 1.2,
  //                 child: CarouselSlider(
  //                     items: _carouselImages
  //                         .map((item) => Padding(
  //                               padding:
  //                                   const EdgeInsets.only(left: 3, right: 3),
  //                               child: Container(
  //                                 decoration: BoxDecoration(
  //                                     image: DecorationImage(
  //                                         image: NetworkImage(item),
  //                                         fit: BoxFit.fitWidth)),
  //                               ),
  //                             ))
  //                         .toList(),
  //                     options: CarouselOptions(
  //                         autoPlay: false,
  //                         enlargeCenterPage: true,
  //                         viewportFraction: 0.8,
  //                         enlargeStrategy: CenterPageEnlargeStrategy.height,
  //                         onPageChanged: (val, carouselPageChangedReason) {
  //                           setState(() {
  //                             _dotPosition = val;
  //                           });
  //                         })),
  //               ),
  //               Text(
  //                 'Discover new destinations',
  //                 style: TextStyle(
  //                   fontSize: 24.0,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.0,
  //               ),
  //               Text(
  //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  //                 style: TextStyle(
  //                   fontSize: 16.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
