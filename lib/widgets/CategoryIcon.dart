import 'package:flutter/material.dart';
import '../constant.dart';

class CategoryIcon extends StatelessWidget {
  VoidCallback onCLick;
  String name;
  String image;
  double size;
  CategoryIcon({Key? key, required this.name, required this.image,this.size = 40, required this.onCLick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCLick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,width: size,color: const Color(0xFF006A4F),),
          const SizedBox(height: 2,),
          Text(name,
            style: const TextStyle(
                color: deepColor,
                fontFamily: 'Bangla'
            ),)
        ],
      ),
    );
  }
}
