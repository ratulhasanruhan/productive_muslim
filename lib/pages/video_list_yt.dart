import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../constant.dart';

class VideoListYT extends StatefulWidget {
  int index;
  VideoListYT({required this.index});

  @override
  State<VideoListYT> createState() => _VideoListYTState();
}

class _VideoListYTState extends State<VideoListYT> {
  final controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        autoPlay: true,
        showFullscreenButton: true,
  ));

  List data = [];
  var initUrl;
  var title;

  String mainurl(){
    if(widget.index == 1){
      return 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PL2FHm7GZu6dkOquL_ZrA9kqsSf6JBhR6N&pageToken=EAAaBlBUOkNESQ&key=$googleAPIkey';
    }if(widget.index == 2){
      return 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PL2FHm7GZu6dkOquL_ZrA9kqsSf6JBhR6N&pageToken=EAAaBlBUOkNHUQ&key=$googleAPIkey';
    }
    if(widget.index == 0){
      return 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PL2FHm7GZu6dkOquL_ZrA9kqsSf6JBhR6N&key=$googleAPIkey';
    }
    return 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PL2FHm7GZu6dkOquL_ZrA9kqsSf6JBhR6N&key=$googleAPIkey';
  }

  getData() async{
    final url = Uri.parse(mainurl());
    final response = await http.get(url);
    setState(() {
      data = json.decode(response.body)['items'];
      title = data[0]['snippet']['title'];
      initUrl = data[0]['snippet']['resourceId']['videoId'];
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

    controller.onInit = () {
      controller.loadVideoById(
          videoId: initUrl ?? 'pmc5q5KpXgc',
      );
    };


    return SafeArea(
      child: Scaffold(
        body: data.isEmpty
        ? Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: data.isEmpty,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 200.h,
                color: Colors.white,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                height: 15.h,
                color: Colors.white,
              ),
            ],
          ),
        )
        : Column(
                children: [

                  YoutubePlayerIFrame(
                    controller: controller,
                    aspectRatio: 16 / 9,
                  ),

                  AppBar(
                    title: Text('Section ${widget.index+1}'),
                  ),

                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: Text(data[index]['snippet']['title'],
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                leading: Icon(Icons.play_circle_outline,
                                  color: primaryColor,),
                                onTap: (){
                                  title = data[index]['snippet']['title'];
                                    initUrl = data[index]['snippet']['resourceId']['videoId'];
                                    controller.loadVideoById( videoId: initUrl,);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );

  }
}
