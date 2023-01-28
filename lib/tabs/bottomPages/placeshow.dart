import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/placeshow.dart';

class Placeshow extends StatelessWidget {
  //const Placeshow({super.key});


  var _place;
  Placeshow(this._place);



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_place['img']),
        ),
        body:Column(
          children: [
            Text(_place['placeName']),
            Text(_place['roadmap']),
            Text(_place['zilla']),

          ],
        )
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