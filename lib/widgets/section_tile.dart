import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

class SectionTile extends StatelessWidget {
  int section;
  int video_length;
  VoidCallback onTap;
  SectionTile({required this.section, required this.video_length, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shadowColor: waterColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.slow_motion_video_sharp,
                    color: primaryColor,),
                  SizedBox(width: 8.w,),
                  Text('Section ${section}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),),
                ],
              ),
              Text('${video_length} videos',
                style: TextStyle(
                  color: deepColor,
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
