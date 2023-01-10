import 'package:flutter/material.dart';

class DivisionPage extends StatefulWidget {
  const DivisionPage({Key? key}) : super(key: key);

  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  List _divisions = ['Dhaka', 'ctg', 'rajshahi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3),
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          itemCount: _divisions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                height: 10,
                width: 10,
                padding: const EdgeInsets.all(20),
                color: Colors.green[100],
                child: Center(child: Text(_divisions[index])),
              ),
            );
          }),
    );
  }
}
