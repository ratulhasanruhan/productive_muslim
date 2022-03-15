import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:productive_muslim/pages/bookmark_hadith.dart';
import 'package:productive_muslim/widgets/loader.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
import '../constant.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class HadithDetails extends StatefulWidget {
  String cate;
  int index;
  String bnname;
  String cname;
  HadithDetails({required this.index, required this.cate, required this.bnname, required this.cname});

  @override
  State<HadithDetails> createState() => _HadithDetailsState();
}

class _HadithDetailsState extends State<HadithDetails> {
  static var box = Hive.box('hadith');

  Future getData()async{
    var url = Uri.parse('https://alquranbd.com/api/hadith/${widget.cate}/${widget.index+1}');
    var res  = await http.get(url);
    var data = json.decode(res.body);
    setState(() {});
    return data;
  }

  String? _parseHtmlString(String htmlString) {
    final document = htmlparser.parse(htmlString);
    final String? parsedString = htmlparser.parse(document.body?.text).documentElement?.text;
    return parsedString;
  }

  String firstLeter(){
    if(widget.cate == 'bukhari'){
      return 'B';
    }
    else if(widget.cate == 'muslim'){
      return 'M';
    }
    else if(widget.cate == 'riyadusSalihin'){
      return 'R';
    }
    else if(widget.cate == 'abuDaud'){
      return 'D';
    }
    else if(widget.cate == 'ibnMajah'){
      return 'M';
    }
    else if(widget.cate == 'tirmidi'){
      return 'T';
    }
    return 'A';
  }

  List arbi = box.get('arbi',defaultValue: []);
  List bangla = box.get('bangla', defaultValue: []);
  List name = box.get('name', defaultValue: []);
  List num = box.get('num', defaultValue: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.cname,
          overflow: TextOverflow.fade,),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HadithBookmark()));
              },
              icon: Icon(Icons.favorite_outline)
          ),
        ],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                          child: Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: Text(snapshot.data[index]['topicName'],
                              style: TextStyle(
                                color: deepColor,
                              ),),
                            ),
                          ),
                          ),
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: waterColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 10.h, right: 10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16.r,
                                          backgroundColor: primaryColor,
                                          child: Text(firstLeter(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(text: 'হাদিস নং ',style: TextStyle(color: darkColor, fontFamily: 'Bangla')),
                                                      TextSpan(text: snapshot.data[index]['hadithNo'],style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold))
                                                    ]
                                                  )
                                              ),
                                              Text(widget.bnname,
                                                style: TextStyle(
                                                  fontFamily: 'Bangla'
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                   Row(
                                     children: [
                                       Container(
                                         padding: EdgeInsets.only(top: 3,right: 2, left: 3),
                                         decoration: BoxDecoration(
                                           color: primaryColor,
                                           borderRadius: BorderRadius.circular(3)
                                         ),
                                         child: Text('সহীহ হাদিস',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                       ),
                                       SizedBox(width: 10.w,),
                                       InkWell(
                                         onTap: (){
                                           arbi.add('${_parseHtmlString(snapshot.data[index]['hadithArabic'])}');
                                           bangla.add('${_parseHtmlString(snapshot.data[index]['hadithBengali'])}');
                                           num.add('${snapshot.data[index]['hadithNo']}');
                                           name.add('${widget.bnname}');

                                           box.put('arbi', arbi);
                                           box.put('num', num);
                                           box.put('name', name);
                                           box.put('bangla', bangla).then((value) {
                                             Fluttertoast.showToast(
                                               msg: 'Bookmarked',
                                               backgroundColor: Colors.pinkAccent,
                                               textColor: Colors.white,
                                             );
                                             print(box.get('bangla'));
                                           });
                                         },
                                           child: Icon(FontAwesomeIcons.heart, color: darkColor, size: 18.r,)
                                       ),
                                       SizedBox(width: 4.w,),
                                       InkWell(
                                         onTap: (){
                                           showDialog(
                                               context: context,
                                               builder: (context){
                                                 return AlertDialog(
                                                   content: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: [
                                                       Text('${widget.bnname}: ${snapshot.data[index]['hadithNo']}',
                                                          style: TextStyle(
                                                            fontFamily: 'Bangla',
                                                          ),
                                                       ),
                                                       SizedBox(
                                                         height: 5,
                                                       ),
                                                       ListTile(
                                                         title: Text('শেয়ার',
                                                           style: TextStyle(
                                                             fontFamily: 'Bangla',
                                                             color: darkColor,
                                                           ),),
                                                         leading: Icon(FontAwesomeIcons.share, color: primaryColor,),
                                                         minLeadingWidth: 5,
                                                         onTap: (){
                                                           Share.share('${_parseHtmlString(snapshot.data[index]['hadithArabic'])}'+
                                                              '\n ${_parseHtmlString(snapshot.data[index]['hadithBengali'])}' +
                                                               '\n ${widget.bnname}: ${snapshot.data[index]['hadithNo']}'
                                                           );
                                                         },
                                                       ),
                                                       ListTile(
                                                         title: Text('সম্পূর্ণ হাদিস কপি',
                                                           style: TextStyle(
                                                             color: darkColor,
                                                             fontFamily: 'Bangla'
                                                           ),),
                                                         leading: Icon(Icons.copy, color: Colors.teal,),
                                                         minLeadingWidth: 5,
                                                         onTap: (){
                                                           FlutterClipboard.copy('${_parseHtmlString(snapshot.data[index]['hadithArabic'])}'+
                                                               '\n ${_parseHtmlString(snapshot.data[index]['hadithBengali'])}' +
                                                               '\n ${widget.bnname}: ${snapshot.data[index]['hadithNo']}')
                                                               .then((value) {
                                                             return Fluttertoast.showToast(
                                                               msg: 'Copied',
                                                               backgroundColor: primaryColor,
                                                               textColor: Colors.white,
                                                             );
                                                           });
                                                           Navigator.pop(context);
                                                         },
                                                       ),
                                                       ListTile(
                                                         title: Text('বাংলা কপি',
                                                           style: TextStyle(
                                                             color: darkColor,
                                                               fontFamily: 'Bangla'
                                                           ),),
                                                         leading: Icon(FontAwesomeIcons.copy, color: Colors.teal,),
                                                         minLeadingWidth: 5,
                                                         onTap: (){
                                                           FlutterClipboard.copy('${_parseHtmlString(snapshot.data[index]['hadithBengali'])}' +
                                                               '\n ${widget.bnname}: ${snapshot.data[index]['hadithNo']}')
                                                               .then((value) {
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
                                         },
                                           child: Icon(FontAwesomeIcons.ellipsisV, color: darkColor, size: 18.r,)
                                       ),
                                     ],
                                   ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text('${_parseHtmlString(snapshot.data[index]['hadithArabic'])}',
                                  textDirection: ui.TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'Qalam',
                                    fontSize: 16,
                                  ),),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: Text('${_parseHtmlString(snapshot.data[index]['hadithBengali'])}',
                                    style: TextStyle(
                                      color: darkColor,
                                      fontFamily: 'Bangla',
                                      fontSize: 16,
                                    ),),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
            );
          }
          return Loader();
        }
      ),
    );
  }
}
