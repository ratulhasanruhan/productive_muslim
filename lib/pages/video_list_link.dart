import 'dart:convert';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoAPI extends StatefulWidget {
  int index;
  VideoAPI({required this.index});

  @override
  State<VideoAPI> createState() => _VideoAPIState();
}

class _VideoAPIState extends State<VideoAPI> {
  List data = [];
  var initUrl;
  var initUrl2;
  var initTitle;
  late FlickManager flickManager;

  getData() async{
    final url = Uri.parse('https://api3.islamhouse.com/v3/paV29H2gm56kvLPy/main/videos/bn/bn/${widget.index}/50/json');
    final response = await http.get(url);
    setState(() {
      data = json.decode(response.body)['data'];
      initTitle = data[0]['title'];
      initUrl = data[0]['attachments'][0]['url'];
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(initUrl ?? 'https://d1.islamhouse.com/data/bn/ih_videos/mp4/single/bn-ghosl.mp4'),
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            FlickVideoPlayer(
                flickManager: flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                controls: FlickPortraitControls(
                  progressBarSettings: FlickProgressBarSettings(
                    playedColor: primaryColor,
                    bufferedColor: deepColor,
                    handleColor: Colors.redAccent,
                    handleRadius: 5.r,
                    backgroundColor: waterColor,
                  ),
                ),
                iconThemeData: IconThemeData(
                  color: primaryColor,
                ),
                textStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            AppBar(
              title: Text(initTitle),
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
                            title: Text(data[index]['title'],
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),),
                            leading: Icon(Icons.play_circle_outline,
                              color: primaryColor,),
                            onTap: (){
                              setState(() {
                                initTitle = data[index]['title'];
                                initUrl = data[index]['attachments'][0]['url'];
                                if(data[index]['attachments']== 1){
                                  initUrl2 =data[index]['attachments'][1]['url'];
                                }
                                flickManager.handleChangeVideo(VideoPlayerController.network(initUrl2 ?? initUrl));
                              });
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
