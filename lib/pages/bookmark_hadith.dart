import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
import '../utils/colors.dart';

class HadithBookmark extends StatefulWidget {
  @override
  State<HadithBookmark> createState() => _HadithBookmarkState();
}

class _HadithBookmarkState extends State<HadithBookmark> {
  static var box = Hive.box('hadith');

  List bangla = box.get('bangla',defaultValue: []);
  List arbi = box.get('arbi',defaultValue: []);
  List name = box.get('name',defaultValue: []);
  List num = box.get('num', defaultValue: []);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Hadith',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
      ),
      body: bangla.isEmpty
      ? Center(
        child: Text('No Hadith Bookmarked!'),
      )
      : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: bangla.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: waterColor,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, top: 10.h, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16.r,
                              backgroundColor: Colors.pinkAccent,
                              child: Icon(Icons.favorite_outline,color: Colors.white,),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'হাদিস নং ',
                                        style: TextStyle(
                                            color: darkColor,
                                            fontFamily: 'Bangla')),
                                    TextSpan(
                                        text: num[num.length -1 -index],
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])),
                                  Text(name[name.length -1 -index],
                                    style: TextStyle(fontFamily: 'Bangla'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 3, right: 2, left: 3),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(3)),
                              child: Text(
                                'সহীহ হাদিস',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                                onTap: () {
                                  arbi.removeAt(arbi.length -1 -index);
                                  bangla.removeAt(bangla.length -1 - index);
                                  num.removeAt(num.length -1 - index);
                                  name.removeAt(name.length -1 -index);

                                  box.put('arbi', arbi);
                                  box.put('bangla', bangla);
                                  box.put('num', num);
                                  box.put('name', name);

                                  Fluttertoast.showToast(
                                    msg: 'Bookmark Deleted',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                    setState(() {});
                                },
                                child: Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.redAccent,
                                  size: 18.r,
                                )),
                            SizedBox(
                              width: 4.w,
                            ),
                            InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '${name[name.length -1 -index]}: ${num[num.length -1 -index]}',
                                                style: TextStyle(
                                                  fontFamily: 'Bangla',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'শেয়ার',
                                                  style: TextStyle(
                                                    fontFamily: 'Bangla',
                                                    color: darkColor,
                                                  ),
                                                ),
                                                leading: Icon(
                                                  FontAwesomeIcons.share,
                                                  color: primaryColor,
                                                ),
                                                minLeadingWidth: 5,
                                                onTap: () {
                                                  Share.share( '${arbi[arbi.length -1 -index]}' +
                                                      '\n ${bangla[bangla.length -1 -index]}' +
                                                      '\n ${name[name.length -1 -index]}: ${num[num.length -1 -index]}');
                                                },
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'সম্পূর্ণ হাদিস কপি',
                                                  style: TextStyle(
                                                      color: darkColor,
                                                      fontFamily: 'Bangla'),
                                                ),
                                                leading: Icon(
                                                  Icons.copy,
                                                  color: Colors.teal,
                                                ),
                                                minLeadingWidth: 5,
                                                onTap: () {
                                                  FlutterClipboard.copy(
                                                          '${arbi[arbi.length -1 -index]}' +
                                                              '\n ${bangla[bangla.length -1 -index]}' +
                                                              '\n ${name[name.length -1 -index]}: ${num[num.length -1 -index]}')
                                                      .then((value) {
                                                    return Fluttertoast
                                                        .showToast(
                                                      msg: 'Copied',
                                                      backgroundColor:
                                                          primaryColor,
                                                      textColor:
                                                          Colors.white,
                                                    );
                                                  });
                                                  Navigator.pop(context);
                                               },
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'বাংলা কপি',
                                                  style: TextStyle(
                                                      color: darkColor,
                                                      fontFamily: 'Bangla'),
                                                ),
                                                leading: Icon(
                                                  FontAwesomeIcons.copy,
                                                  color: Colors.teal,
                                                ),
                                                minLeadingWidth: 5,
                                                onTap: () {
                                                  FlutterClipboard.copy(
                                                          '${bangla[bangla.length -1 -index]}' +
                                                              '\n ${name[name.length -1 -index]}: ${num[num.length -1 -index]}')
                                                      .then((value) {
                                                    return Fluttertoast
                                                        .showToast(
                                                      msg: 'Copied',
                                                      backgroundColor:
                                                          primaryColor,
                                                      textColor:
                                                          Colors.white,
                                                    );
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Icon(
                                  FontAwesomeIcons.ellipsisV,
                                  color: darkColor,
                                  size: 18.r,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '${arbi[arbi.length -1 -index]}',
                      textDirection: ui.TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Qalam',
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        '${bangla[bangla.length -1 -index]}',
                        style: TextStyle(
                          color: darkColor,
                          fontFamily: 'Bangla',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
