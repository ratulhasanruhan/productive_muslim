import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:productive_muslim/controller/quran_search_delegate.dart';
import 'package:productive_muslim/pages/fatwa_pdf.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List data = [];
  bool nointernet = false;
  var next;

  getData() async{
    final url = Uri.parse('https://api3.islamhouse.com/v3/paV29H2gm56kvLPy/main/books/bn/bn/1/25/json');
    final response = await http.get(url);
    setState(() {
      data = json.decode(response.body)['data'];
      next = json.decode(response.body)['links']['next'];
    });
    return data;
  }

  timer() async{
    await Future.delayed(const Duration(seconds: 7), () {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Books',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
        actions: [
          IconButton(
              onPressed: (){
               showSearch(
                   context: context,
                   delegate: QuranSearchDelegate(data: List.generate(data.length, (index) => data[index]['title']))
               );
              },
              icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: data.isEmpty
      ? const Center(child: CircularProgressIndicator(color: greenColor,),)
      : ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 12.h, top: 4.h),
            child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: data.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180.h,
                    childAspectRatio: 2/2.5,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                ),
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r)
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: 'https://crud.appworld.top/open_book.png',
                                  fit: BoxFit.cover,
                                  height: 150.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(data[index]['title'],
                                  style: const TextStyle(
                                    fontFamily: 'Bangla',
                                    fontSize: 18
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(data[index]['description'],
                                  style: const TextStyle(
                                    color: darkColor,
                                    fontSize: 14
                                  ),),
                              ],
                            ),
                          ),
                          actionsPadding: const EdgeInsets.only(top: 0),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: const Text('Close')
                            ),
                            RawMaterialButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FatwaPdf(link: data[index]['attachments'][0]['url'], name: data[index]['title'])));
                                },
                              child: const Text('Read',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              fillColor: primaryColor,
                            ),
                          ],
                        );
                      }
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  shadowColor: waterColor,
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h, right: 8.w, left: 8.w),
                          child: CachedNetworkImage(
                            imageUrl: 'https://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/book-icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.w, bottom: 8.h,right: 6.w, left: 6.w),
                        child: Text(data[index]['title'],
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            fontFamily: 'Bangla',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            ),
          ),
          TextButton(
            onPressed: () async{
              Fluttertoast.showToast(msg: 'Please Wait...', backgroundColor: Colors.green, textColor: Colors.white,toastLength: Toast.LENGTH_LONG);
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
