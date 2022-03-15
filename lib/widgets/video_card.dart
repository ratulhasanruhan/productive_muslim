import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget {
  List<Color> colorList;
  String title;
  String image;
  VoidCallback onClick;
  double padHeight;
  double padWeight;
  double textRightPad;
  VideoCard({required this.colorList, required this.image, required this.title, required this.onClick, this.padHeight=0, this.padWeight=0 , this.textRightPad =0});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colorList,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padWeight,vertical: padHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(imageUrl: image),
                Padding(
                  padding: EdgeInsets.only(right: textRightPad),
                  child: Text(title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        fontFamily: 'Sofia Bold'
                    ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
