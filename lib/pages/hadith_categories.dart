import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import 'package:productive_muslim/controller/quran_search_delegate.dart';
import 'package:productive_muslim/pages/hadith_details.dart';
import 'package:productive_muslim/widgets/loader.dart';

class CateHadith extends StatefulWidget {
  String name;
  String cate;
  int index;
  CateHadith({required this.cate, required this.name, required this.index});

  @override
  _CateHadithState createState() => _CateHadithState();
}

class _CateHadithState extends State<CateHadith> {
  int oddhay = 0;
  bool nointernet = false;
  var dn;
  NumberFormat formatter = new NumberFormat("00");

  Future getCate()async{
    var url = Uri.parse('https://alquranbd.com/api/hadith/${widget.cate}');
    var res  = await http.get(url);
    var data = json.decode(res.body);
    oddhay = data.length;
    dn = data;
    setState(() {});
    return data;
  }

  timer() async{
    await Future.delayed(Duration(seconds: 7), () {
      setState(() {
        nointernet = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor[widget.index],
        elevation: 0,
        title: Column(
          children: [
            Text(widget.name,
              style: TextStyle(
                fontFamily: 'Bangla',
              ),),
            Text('$oddhay অধ্যায়',
              style: TextStyle(
                fontSize: 12,
              ),)
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: QuranSearchDelegate(data: List.generate(dn.length, (index) => dn[index]['nameBengali'])),
                );
              },
              icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCate(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    child: Card(
                      color: waterColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      shadowColor: waterColor,
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HadithDetails(index: index, cate: widget.cate, bnname: widget.name, cname: snapshot.data[index]['nameBengali'],)));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(snapshot.data[index]['nameBengali'],
                              softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Bangla'
                              ),),
                            ),
                            Text('${snapshot.data[index]['range_start']} থেকে ${snapshot.data[index]['range_end']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: deepColor
                              ),)
                          ],
                        ),
                        leading: Neumorphic(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              color: waterColor,
                              depth: -3,
                              shape: NeumorphicShape.concave),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Text(formatter.format(index+1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkColor
                              ),),
                          ),
                        ),
                        minLeadingWidth: 5,
                      ),
                    ),
                  );
                }
            );
          }
          return Loader(nointernet: nointernet,);
          },
      ),
    );
  }
}
