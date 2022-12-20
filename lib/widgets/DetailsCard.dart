import 'package:flutter/material.dart';
import '../utils/colors.dart';


class DetailsCard extends StatelessWidget {
  String title;
  String desc;
  String number;
  DetailsCard({Key? key, required this.title, required this.desc, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: waterColor,
      elevation: 6,
      color: Colors.white,
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
        title: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: const TextStyle(
                    color: zColor,
                    fontFamily: 'Bangla',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: const TextStyle(
                      fontFamily: 'Bangla',
                      color: Colors.black87
                  ),
                ),
              ]
          ),
        ),
        backgroundColor: Colors.white,
        trailing: const Icon(Icons.add, color: Colors.black87,),
        children: [
          Text(desc),
        ],
      ),
    );
  }
}
