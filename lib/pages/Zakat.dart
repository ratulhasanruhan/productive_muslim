import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productive_muslim/constant.dart';

class Zakat extends StatefulWidget {
  const Zakat({Key? key}) : super(key: key);

  @override
  State<Zakat> createState() => _ZakatState();
}

class _ZakatState extends State<Zakat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('যাকাত',
          style: TextStyle(
            color: Colors.black,
          ),),
        shadowColor: waterColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shadowColor: waterColor,
              child: ExpansionTile(
                title: Text('যাকাত বন্টনের নির্ধারিত খাত'),
                backgroundColor: waterColor,
                trailing: Icon(Icons.add),
                collapsedBackgroundColor: Colors.white,
                children: [
                  Text(''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
