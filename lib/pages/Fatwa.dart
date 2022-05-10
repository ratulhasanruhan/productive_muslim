import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:productive_muslim/constant.dart';
import 'package:productive_muslim/pages/fatwa_pdf.dart';
import 'package:http/http.dart' as http;

class Fatwa extends StatefulWidget {
  const Fatwa({Key? key}) : super(key: key);


  @override
  State<Fatwa> createState() => _FatwaState();
}

class _FatwaState extends State<Fatwa> {
  NumberFormat formatter = NumberFormat("00");
  List data = [];
  var next;
  bool nointernet = false;

  getData() async{
    final url = Uri.parse('https://api3.islamhouse.com/v3/paV29H2gm56kvLPy/main/fatwa/bn/bn/1/25/json');
    final response = await http.get(url);
    setState(() {
      data = json.decode(response.body)['data'];
      next = json.decode(response.body)['links']['next'];
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Fatwa",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: appbarColor[5],
      ),
      body: data.isEmpty
      ? Center(child: CircularProgressIndicator(color: appbarColor[5],),)
      : ListView(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: data.length,
              itemBuilder: (context, index){
              return ExpansionTile(
                title: Text(data[index]['title'],
                    style: const TextStyle(
                      fontFamily: 'Bangla',
                    ),
                ),
                leading: CircleAvatar(
                  maxRadius: 15.r,
                  backgroundColor: waterColor,
                  child: Text(formatter.format(index+1)),
                ),
                childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
                children: [
                  Html(data: data[index]['full_description']),
                 // Text(DateFormat('dd-m-yyyy').format(DateTime.fromMicrosecondsSinceEpoch(data[index]['add_date'])))
                  RawMaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FatwaPdf(link: data[index]['attachments'][0]['url'], name: data[index]['title'],)));
                      },
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: const Text('More Details',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      side: const BorderSide(color: primaryColor)
                    ),
                  ),
                  SizedBox(height: 5.w,)
                ],
              );
              }
          ),
          TextButton(
              onPressed: () async{
                final response = await http.get(Uri.parse(next));
                setState(() {
                  data.addAll(json.decode(response.body)['data']);
                  next = json.decode(response.body)['links']['next'];
                });
              },
              child: const Text('Load More...',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),),
          ),
        ],
      ),
    );
  }
}
