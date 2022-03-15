import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:productive_muslim/constant.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FatwaPdf extends StatefulWidget {
  String link;
  String name;
  FatwaPdf({required this.link, required this.name});

  @override
  State<FatwaPdf> createState() => _FatwaPdfState();
}

class _FatwaPdfState extends State<FatwaPdf> {
  PdfViewerController? controller;
  var pageNumber = 1;
  var pg;

  @override
  void initState() {
    super.initState();
    controller = PdfViewerController();
    Fluttertoast.showToast(msg: 'Please wait. Loading...', backgroundColor: Colors.green, textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Go to page'),
                            SizedBox(height: 15.h,),
                            TextField(
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              onChanged: (te){
                                setState(() {
                                  pg = te;
                                });
                              },
                              maxLength: controller?.pageCount.toString().length,
                              decoration: InputDecoration(
                                hintText: 'Page Number',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                          ),
                          TextButton(
                              onPressed: (){
                                if(controller!.pageCount < int.parse(pg)){
                                  Fluttertoast.showToast(msg: 'Invalid Page', backgroundColor: Colors.red, textColor: Colors.white);
                                }else{
                                  controller?.jumpToPage(int.parse(pg));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Ok'),
                          ),
                        ],
                      );
                    }
                );
              },
              icon: Icon(Icons.find_in_page)
          ),
          IconButton(
              onPressed: (){
                controller?.previousPage();
              },
              icon: Icon(Icons.arrow_back_ios)
          ),
          Center(
            child: Text(
              '$pageNumber/${controller?.pageCount}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
              onPressed: (){
                controller?.nextPage();
              }, 
              icon: Icon(Icons.arrow_forward_ios_sharp)
          ),
        ],
      ),
        body: Container(
          color: Colors.white,
        child: SfPdfViewer.network(
          widget.link,
          controller: controller,
          onPageChanged: (pd){
            setState(() {
              pageNumber = pd.newPageNumber;
            });
          },
          onDocumentLoaded: (pd){
            setState(() {

            });
          },
        ),
        ),
    );
  }
}
