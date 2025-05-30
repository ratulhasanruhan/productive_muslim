import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetails extends StatelessWidget {
  final data;
  const BlogDetails({Key? key, required this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.h,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: data['yoast_head_json']['og_image'][0]['url'],
                placeholder: (context, url) {
                  return Image.network('https://www.innovatrics.com/wp-content/themes/innovatrics/assets/img/article-placeholder.png',fit: BoxFit.cover,);
                },
                errorWidget: (context, url, error){
                  return Image.network('https://www.innovatrics.com/wp-content/themes/innovatrics/assets/img/article-placeholder.png', fit: BoxFit.cover,);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(6.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(data['title']['rendered'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              SharePlus.instance.share(data['guid']['rendered']);
                            },
                            icon: Icon(Icons.share),
                          ),
                          IconButton(
                            onPressed: ()async{
                              await launchUrl(Uri.parse(data['guid']['rendered']));
                            },
                            icon: Icon(Icons.open_in_browser),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Html(data: data['content']['rendered'],
                    onLinkTap: (stri, map, ele) async{
                      await launchUrl(Uri.parse(stri!));
                    },
                    shrinkWrap: true,
                  ),
                  SizedBox(height: 6.w,),
                  Text('Written by: ${data['yoast_head_json']['twitter_misc']['Written by']}', textAlign: TextAlign.end,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
