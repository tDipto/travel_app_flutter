import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/divisionPage.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: (Center(
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
                          builder: (_) => DivisionPage(_mdivisions[index]))),
                );
              }))),
    ));
  }
}
