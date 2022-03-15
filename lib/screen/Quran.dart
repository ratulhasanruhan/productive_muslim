import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:productive_muslim/constant.dart';
import 'package:productive_muslim/controller/quran_search_delegate.dart';
import 'package:productive_muslim/pages/quran_details.dart';
import 'dart:ui' as ui;

import 'package:share_plus/share_plus.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  bool bcolor = true;
  NumberFormat formatter = new NumberFormat("00");
  PageController controller = PageController();
  static var box = Hive.box('home');
  TextEditingController searchText = TextEditingController();

  List data = [];
  List arabic = [];

  Future loadData() async {
    var jsonText = await rootBundle.loadString('assets/bangla_quran.json');
    final item = json.decode(jsonText);
   setState(() {
     data = item['data']['surahs'];
   });

  }
  Future loadArabic() async {
    var jsonText = await rootBundle.loadString('assets/arabic_quran.json');
    final item = json.decode(jsonText);
    setState(() {
      arabic = item['data']['surahs'];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    loadArabic();
  }

  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    List? bIn = box.get('bIndex');
    List? aIn = box.get('aIndex');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0AC594),
        elevation: 1,
        title: Text('Al-Qur\'an',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: QuranSearchDelegate(data: List.generate(data.length, (index) => data[index]['englishName'])),
                );
              },
              icon: Icon(Icons.search),
          ),
        ],
      ),

      body: Column(
        children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 0,
                    onPressed: (){
                      setState(() {
                        controller.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                        bcolor = true;
                      });
                    },
                    color: bcolor ? secondaryColor : waterColor,
                    child: Text('Surah',
                      style: TextStyle(
                        color: bcolor ?Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),bottomLeft: Radius.circular(20.r))
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r))
                    ),
                    onPressed: (){
                      setState(() {
                        controller.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                        bcolor = false;
                      });
                    },
                    child: Text('Bookmark',
                      style: TextStyle(
                        color: bcolor ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    color: bcolor ? waterColor : secondaryColor,
                  ),
                ],
              ),
            ),

                Flexible(
                  child: PageView(
                    onPageChanged: (num){
                      if(num == 0){
                        setState(() {
                          bcolor = true;
                        });
                      }
                      else{
                        setState(() {
                          bcolor = false;
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    controller: controller,
                    children: [
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context,index){

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(data[index]['englishName'],
                                      style: TextStyle(
                                        color: darkColor,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    leading: CircleAvatar(
                                      backgroundColor: secondaryColor,
                                      child: Text(formatter.format(index+1),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ),
                                    subtitle: Text(data[index]['englishNameTranslation'],
                                      style: TextStyle(
                                        color: deepColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsQuran(data: data[index], arab: arabic[index], aindex: index,)));
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Divider(thickness: 1.2,color: waterColor,height: 4.h,),
                                  ),
                                ],
                              ),
                            );

                          }
                      ),

                      bIn == null
                      ? Center(child: Text('No bookmark found'))
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bIn.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                //color: waterColor,
                                shadowColor: waterColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(arabic[aIn![aIn.length -1 -index]]['ayahs'][bIn[bIn.length -1 -index]]['text'],
                                          textDirection: ui.TextDirection.rtl,
                                          style: TextStyle(
                                            fontFamily: 'Qalam',
                                            fontSize: 18,
                                          ),),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Text(data[aIn[aIn.length -1 -index]]['ayahs'][bIn[bIn.length -1 -index]]['text'],
                                            style: TextStyle(
                                              color: darkColor,
                                              fontFamily: 'Bangla',
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Divider(color: deepColor,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(data[aIn[aIn.length -1 -index]]['englishName']+": "+'${bIn[bIn.length -1 -index]+1}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Sofia Bold',
                                                fontSize: 16
                                            ),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Icon(Icons.copy,color: Colors.indigo,),
                                                radius: 40,
                                                onTap: (){
                                                  FlutterClipboard.copy(data[aIn[aIn.length -1 -index]]['ayahs'][bIn[bIn.length -1 -index]]['text']+"\n"
                                                      + data[aIn[aIn.length -1 -index]]['englishName']+": "+'${bIn[bIn.length -1 -index]+1}')
                                                      .then((value) {
                                                    return Fluttertoast.showToast(
                                                      msg: 'Copied',
                                                      backgroundColor: primaryColor,
                                                      textColor: Colors.white,
                                                    );
                                                  });
                                                },
                                              ),
                                              SizedBox(width: 10.w,),
                                              InkWell(
                                                child: Icon(FontAwesomeIcons.share,color: primaryColor,),
                                                radius: 40,
                                                onTap: (){
                                                  Share.share(data[aIn[aIn.length -1 -index]]['ayahs'][bIn[bIn.length -1 -index]]['text']+"\n"
                                                      + data[aIn[aIn.length -1 -index]]['englishName']+": "+'${bIn[bIn.length -1 -index]+1}');
                                                },
                                              ),
                                              SizedBox(width: 10.w,),
                                              InkWell(
                                                child: Icon(FontAwesomeIcons.solidHeart,color: Colors.redAccent,),
                                                radius: 40,
                                                onTap: (){
                                                  aIn.removeAt(aIn.length -1 -index);
                                                  bIn.removeAt(bIn.length -1 -index);
                                                  Fluttertoast.showToast(
                                                    msg: 'Bookmark Deleted',
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                  );
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      )


                    ],
                  ),
                )




          ],
        ),
    );
  }
}
