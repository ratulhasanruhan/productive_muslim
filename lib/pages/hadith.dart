import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import 'package:productive_muslim/pages/bookmark_hadith.dart';
import 'package:productive_muslim/pages/hadith_categories.dart';

class Hadith extends StatefulWidget {

  @override
  _HadithState createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  List data = [];
  NumberFormat formatter = new NumberFormat("00");

  Future loadData() async {
    var jsonText = await rootBundle.loadString('assets/hadith.json');
    final item = json.decode(jsonText);
    setState(() {
      data = item;
    });
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
        backgroundColor: Color(0xFF2B355A),
        elevation: 3,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HadithBookmark()));
              },
              icon: Icon(Icons.favorite_border)
          ),
        ],
        title: Text('Hadith',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  color:  waterColor,
                  shadowColor: waterColor,
                  elevation: 3,
                  child: ListTile(
                    onTap: (){
                      if(data[index]['book_key'] == ""){
                        Fluttertoast.showToast(msg: 'Coming Soon...', backgroundColor: primaryColor,fontSize: 16);
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CateHadith(cate: data[index]['book_key'], name: data[index]['nameBengali'],index: index,)));
                      }
                    },
                    leading: CircleAvatar(
                      backgroundColor: backColor,
                        child: CachedNetworkImage(
                          imageUrl: data[index]['image'],
                          fit: BoxFit.cover,
                          errorWidget: (context, st, d){
                            return Text(formatter.format(index+1),
                              style: TextStyle(
                                fontSize: 16,
                                color: darkColor,
                              ),);
                            },
                          placeholder: (context, st){
                            return Text(formatter.format(index+1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkColor,
                              ),);
                          },
                        )
                    ),
                    title: Text(data[index]['nameBengali'],
                      style: TextStyle(
                        fontFamily: 'Bangla',
                        color: darkColor,
                      ),),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data[index]['nameEnglish'],
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        Text('${data[index]['hadith_number']} হাদিস',
                          style: TextStyle(
                            fontSize: 12,
                            color: darkColor,
                          ),),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
