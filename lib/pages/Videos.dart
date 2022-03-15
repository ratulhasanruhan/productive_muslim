import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:productive_muslim/constant.dart';
import 'package:productive_muslim/pages/video_list_link.dart';
import 'package:productive_muslim/pages/video_list_yt.dart';
import 'package:productive_muslim/widgets/section_tile.dart';
import 'package:productive_muslim/widgets/video_card.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  ExpandableController controller1 = ExpandableController();
  ExpandableController controller2 = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: waterColor,
      appBar: AppBar(
        backgroundColor: waterColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: darkColor,
        ),
        title: Text(
          'Videos',
          style: TextStyle(
            color: darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ExpandableNotifier(
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: true,
                    child: ExpandablePanel(
                      controller: controller1,
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                        tapHeaderToExpand: true,
                        tapBodyToExpand: true,
                        hasIcon: false,
                      ),
                      header: VideoCard(
                          colorList: [Color(0xFFad5389), Color(0xFF3c1053)],
                          image: 'http://crud.appworld.top/quran.png',
                          title: 'Learn Quran\nEasily',
                          textRightPad: 8.w,
                          onClick: () {
                            setState(() {
                              controller1.value = !controller1.value;
                            });
                          }),
                      collapsed: Container(),
                      expanded: Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (_ , index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: SectionTile(
                                    section: index+1,
                                    video_length: 50,
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoListYT(index: index,)));
                                    },
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      controller: controller2,
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                        tapHeaderToExpand: true,
                        tapBodyToExpand: true,
                        hasIcon: false,
                      ),
                      header: VideoCard(
                          colorList: [Color(0xFF5E5DA5), Color(0xFF3c1053)],
                          image: 'https://cdn-icons-png.flaticon.com/128/4336/4336680.png',
                          title: 'Know About\n Islam',
                          padWeight: 15.w,
                          padHeight: 5.h,
                          onClick: () {
                            setState(() {
                              controller2.value = !controller2.value;
                            });
                          }
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 7,
                              itemBuilder: (_ , index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: SectionTile(
                                    section: index+1,
                                    video_length: 50,
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoAPI(index: index+1,)));
                                    },
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
