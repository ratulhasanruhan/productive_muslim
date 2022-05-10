import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:productive_muslim/constant.dart';
import 'package:productive_muslim/pages/blog_details.dart';
import 'package:productive_muslim/widgets/loader.dart';
import 'package:html/parser.dart' as htmlparser;

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List data = [];
  bool nointernet = false;

  getData() async{
    try{
      var url = Uri.parse(blogApi);
      final response = await http.get(url);
      setState(() {
        data = json.decode(response.body);
      });
      return data;
    }catch(e){
      print(e);
    }
  }

  timer() async{
    await Future.delayed(Duration(seconds: 9), () {
      setState(() {
        nointernet = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    timer();
  }

  String? _parseHtmlString(String htmlString) {
    final document = htmlparser.parse(htmlString);
    final String? parsedString = htmlparser.parse(document.body?.text).documentElement?.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Blog',
          style: TextStyle(
            color: darkColor,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: darkColor,
        ),
      ),
      body: data.isEmpty
      ? const Center(child: CircularProgressIndicator(color: Color(0xFF006A4F),),)
      : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Card(
                    elevation: 0,
                    color: backColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6.r),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails(data: data[index])));
                      },
                      child: Row(
                        children: [
                         ClipRRect(
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), bottomLeft: Radius.circular(6.r)),
                           child: CachedNetworkImage(
                             imageUrl: data[index]['yoast_head_json']['og_image'][0]['url'],
                             placeholder: (context, url) {
                               return Image.network('https://www.innovatrics.com/wp-content/themes/innovatrics/assets/img/article-placeholder.png',fit: BoxFit.cover,);
                             },
                             errorWidget: (context, url, error){
                               return Image.network('https://www.innovatrics.com/wp-content/themes/innovatrics/assets/img/article-placeholder.png', fit: BoxFit.cover,);
                             },
                             height: 70.h,
                             width: 70.w,
                             fit: BoxFit.cover,
                           ),
                         ),
                          SizedBox(width: 12.w,),
                          Flexible(
                            child: Text(
                              _parseHtmlString(data[index]['title']['rendered'])!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: darkColor,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
        },
      ),

    );
  }
}
