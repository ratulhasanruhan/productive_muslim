import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

class DetailsQuran extends StatefulWidget {
  var data;
  var arab;
  int aindex;
  DetailsQuran({required this.data, required this.arab, required this.aindex});

  @override
  State<DetailsQuran> createState() => _DetailsQuranState();
}

class _DetailsQuranState extends State<DetailsQuran> {
  String image() {
    if (widget.data['revelationType'] == 'Meccan') {
      return 'assets/mecca.png';
    }
    return 'assets/madina.jpg';
  }

  NumberFormat formatter = new NumberFormat("00");
  static var box = Hive.box('home');

  List aList = box.get('aIndex',defaultValue: []);
  List bList = box.get('bIndex', defaultValue: []);

  @override
  Widget build(BuildContext context) {


    options(int index){
      String nameAyah = widget.data['englishName']+': ' +formatter.format(index+1);
      showDialog(
          context: context,
          builder: (context){
            return  AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(nameAyah,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text('Bookmark',
                      style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: Icon(FontAwesomeIcons.heart, color: Colors.redAccent,),
                    minLeadingWidth: 5,
                    onTap: () {
                      aList.add(widget.aindex);
                      bList.add(index);

                      box.put('aIndex', aList);
                      box.put('bIndex', bList).then((value) {
                        Fluttertoast.showToast(
                          msg: 'Bookmarked',
                          backgroundColor: Colors.pinkAccent,
                          textColor: Colors.white,
                        );
                        print(box.get('bIndex'));
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Share',
                      style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: Icon(FontAwesomeIcons.share, color: primaryColor,),
                    minLeadingWidth: 5,
                    onTap: (){
                      Share.share(widget.data['ayahs'][index]['text'] + '\n' + nameAyah,subject: nameAyah);
                    },
                  ),
                  ListTile(
                    title: Text('Copy',
                      style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: Icon(FontAwesomeIcons.copy, color: Colors.teal,),
                    minLeadingWidth: 5,
                    onTap: (){
                      FlutterClipboard.copy(widget.data['ayahs'][index]['text'] + '\n' + nameAyah).then((value) {
                        return Fluttertoast.showToast(
                          msg: 'Copied',
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                        );
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                  ),
                  builder: (context){
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Please click any Ayah for get options.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 18
                            ),),
                          SizedBox(height: 5.h,),
                          Text('Please swipe Right,\nto get your Favourite list',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                            ),),
                          OutlinedButton(
                            onPressed: (){
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            },
                            child: Text('Go Back'),
                          )
                        ],
                      ),
                    );
                  }
              );
            },
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
        centerTitle: true,
        title: Text(
          widget.data['englishName'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      image(),
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data['name'],
                          style: const TextStyle(
                            color: darkColor,
                          ),
                        ),
                        Text(
                          widget.data['englishNameTranslation'],
                          style: const TextStyle(
                            color: darkColor,
                          ),
                        ),
                        Text(widget.data['revelationType'],
                            style: const TextStyle(
                              color: darkColor,
                            )),
                        Text('Ayah: ' + widget.data['ayahs'].length.toString(),
                            style: const TextStyle(
                              color: darkColor,
                            )),
                      ],
                    ),
                  ],
                ),
                const Text(
                  'بِسْمِ ٱللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Divider(
                    thickness: 1.5,
                    color: waterColor,
                    height: 6.h,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.data['ayahs'].length,
              itemBuilder: (context, index) {
                if (widget.data['ayahs'].isNotEmpty) {
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: primaryColor, width: 1.4),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(7.r),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.arab['ayahs'][index]['text'],
                                softWrap: true,
                                textDirection: ui.TextDirection.rtl,
                                style: TextStyle(
                                  color: darkColor,
                                  fontFamily: 'Qalam',
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
                          child: Text(
                            widget.data['ayahs'][index]['text'],
                            style: const TextStyle(
                              color: darkColor,
                              fontFamily: 'Bangla',
                              fontSize: 17,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        isThreeLine: true,
                        onTap: (){
                          options(index);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Divider(
                          thickness: 1.2,
                          color: waterColor,
                          height: 4.h,
                        ),
                      ),
                    ],
                  );
                }
                return const CupertinoActivityIndicator();
              }),
        ],
      ),
    );
  }
}
