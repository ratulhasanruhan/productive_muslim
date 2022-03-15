import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:productive_muslim/controller/quran_search_delegate.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
import '../constant.dart';

class AllahNames extends StatefulWidget {

  @override
  _AllahNamesState createState() => _AllahNamesState();
}

class _AllahNamesState extends State<AllahNames> {
  NumberFormat formatter = new NumberFormat("00");

  List data = [];

  Future loadData() async {
    var jsonText = await rootBundle.loadString('assets/allah_names.json');
    final item = json.decode(jsonText);
    setState(() {
      data = item['data'];
    });
  }

  options(int index){
    showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data[index]['transliteration'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(
                  height: 5,
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
                    Share.share(data[index]['transliteration']+'\n' + data[index]['en']['meaning']);
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
                    FlutterClipboard.copy(data[index]['transliteration']+'\n' + data[index]['en']['meaning']).then((value) {
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        centerTitle: true,
        title: Text('99 Names',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context, 
                    delegate: QuranSearchDelegate(data: List.generate(data.length, (index) => data[index]['transliteration']))
                );
              },
              icon: Icon(Icons.search, color: primaryColor,)
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: data.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    options(index);
                  },
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 8.w, right: 11.w),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomRight: Radius.circular(15.r))
                                ),
                                child: Text(formatter.format(index+1),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index]['transliteration'],
                                      style: TextStyle(
                                        color: darkColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                    SizedBox(height: 2,),
                                    Text(data[index]['en']['meaning'],
                                      style: TextStyle(
                                        color: darkColor,
                                        fontSize: 13
                                      ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(data[index]['name'],
                            textDirection: ui.TextDirection.rtl,
                            style: TextStyle(
                              color: darkColor,
                              fontFamily: 'Qalam',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
