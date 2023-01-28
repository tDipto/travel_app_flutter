import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/divisionPage.dart';

class MainDivisionPage extends StatefulWidget {
  const MainDivisionPage({Key? key}) : super(key: key);

  @override
  _MainDivisionPageState createState() => _MainDivisionPageState();
}

class _MainDivisionPageState extends State<MainDivisionPage> {
  List _mdivisions = ['ঢাকা', 'চট্টগ্রাম', 'রাজশাহী'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
        Column(children: [
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _mdivisions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
              itemBuilder: (_, index){
              return GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DivisionPage(_mdivisions[index]))),
                child: Card(
                  elevation: 3,
                  child: Column(children: [
                    Text("${_mdivisions[index]}"),
                    
                  ]),
                ),
              );
            }) 
          )
        ])
      )
    );
  }
}
