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
  void initState() {
    fetchCarouselImages();
    // fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 248, 243),
        body: SafeArea(
            child: Container(
                child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              readOnly: true,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                // ignore: prefer_const_constructors
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 220, 232, 243))),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: "Search Place here",
                hintStyle: const TextStyle(fontSize: 15),
              ),
              // onTap: () => Navigator.push(
              //     context, CupertinoPageRoute(builder: (_) => SearchScreen())),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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
          SizedBox(
            height: 10.h,
          ),
          DotsIndicator(
            dotsCount: _carouselImages.length == 0 ? 1 : _carouselImages.length,
            position: _dotPosition.toDouble(),
            // ignore: prefer_const_constructors
            decorator: DotsDecorator(
              activeColor: Colors.lightBlueAccent,
              color: Colors.greenAccent,
              spacing: EdgeInsets.all(2),
              activeSize: Size(8, 8),
              size: Size(6, 6),
            ),
          ),
        ]))));
  }
}
