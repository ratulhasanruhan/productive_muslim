import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import 'package:productive_muslim/controller/quran_search_delegate.dart';
import 'package:productive_muslim/pages/quran_details.dart';
import 'dart:ui' as ui;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as Tb;


class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin{
  NumberFormat formatter = new NumberFormat("00");
  PageController controller = PageController();
  static var box = Hive.box('home');
  TextEditingController searchText = TextEditingController();

  int index = 0;
  int cupertinoTabBarIIIValueGetter() => index;

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
    List? bIn = box.get('bIndex');
    List? aIn = box.get('aIndex');

    var lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(lang.al_quran,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: kJava,
          ),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: kJava,
        ),
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: QuranSearchDelegate(data: List.generate(data.length, (index) => data[index]['englishName'])),
                );
              },
              icon: Icon(FeatherIcons.search),
          ),
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w,),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kJava,
                    primaryColor,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(FeatherIcons.bookOpen,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(lang.last_read,
                            style: TextStyle(
                              color: Colors.white,
                            ),),
                        ],
                      ),

                      SizedBox(
                        height: 25.h,
                      ),

                      Text('Al-Fatiah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),),
                      Text('Meccan - 7 Ayat',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ],
                  ),
                  Image.asset(
                      'assets/quran.png',
                    height: 110.h,
                    width: 110.w,

                  )
                ],
              ),
            ),
          ),

           SizedBox(
             height: 16.h,
           ),

          Tb.CupertinoTabBar(
            zColor,
            Colors.white,
            [
               Text(
                lang.surah,
                style: TextStyle(
                  color: index == 0 ? kGreen :Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                lang.juz,
                style: TextStyle(
                  color: index == 1 ? kGreen :Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                lang.bookmark,
                style:  TextStyle(
                  color: index == 2 ? kGreen :Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            cupertinoTabBarIIIValueGetter, (int i) {
              setState(() {
                index = i;
                controller.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              });
            },
            useSeparators: true,
            useShadow: false,
          ),

          SizedBox(
            height: 6.h,
          ),

          Expanded(
            child: PageView(
                    onPageChanged: (num){
                      setState(() {
                        index = num;
                      });
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
                          primary: false,
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
