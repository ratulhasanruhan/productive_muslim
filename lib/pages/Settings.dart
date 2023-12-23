import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:productive_muslim/controller/langCOntroller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../constant.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static var box = Hive.box('home');
  String mainValue = box.get('madhab', defaultValue: 'Hanafi');
  TextEditingController reportCont = TextEditingController();
  TextEditingController feedbackCont = TextEditingController();

  CollectionReference fire = FirebaseFirestore.instance.collection('feedback');

  Future addData(String type, String message, DateTime time)async{
    return fire.add({
      'message' : message,
      'type' : type,
      'time' : time,
    }).then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Succesfully $type', backgroundColor: primaryColor, textColor: Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Common Settings',
            titlePadding: EdgeInsets.only(top: 8.h,  left: 12.w, bottom: 2.h),
            tiles: [
              SettingsTile(
                title: 'Madhab',
                leading: const Icon(FontAwesomeIcons.mosque, size: 20),
                onPressed: (BuildContext context) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            alignment: Alignment.center,
                            title: const Text(
                              'Salat Settings',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: darkColor, fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            content: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButton(
                                          hint: const Text('Madhab'),
                                          value: mainValue,
                                          items: const [
                                            DropdownMenuItem(
                                              child: Text('Hanafi'),
                                              value: 'Hanafi',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Shafi, Maliki, Hanbli'),
                                              value: 'Shafi',
                                            ),
                                          ],
                                          onChanged: (String? value) {
                                            setState(() {
                                              mainValue = value!;
                                            });
                                          }),
                                    ],
                                  );
                                }
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),

                              TextButton(
                                child: const Text('Update'),
                                onPressed: () {
                                  box.put('madhab', mainValue);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        });
                },
              ),
              SettingsTile(
                title: 'App System',
                leading: const Icon(Icons.settings_applications_outlined),
                onPressed: (BuildContext context) async{
                  await AppSettings.openAppSettings();
                },
              ),  
              SettingsTile(
                title: 'Clear Cache',
                leading: const Icon(Icons.cleaning_services),
                onPressed: (BuildContext context) async{
                  await DefaultCacheManager().emptyCache().then((value) {
                    Fluttertoast.showToast(msg: 'Cache Cleared', backgroundColor: Colors.redAccent, textColor: Colors.white);
                  });
                },
              ),
              SettingsTile(
                title: 'Update',
                leading: const Icon(Icons.arrow_circle_up),
                onPressed: (BuildContext context) async{
                  await launch('https://play.google.com/store/apps/details?id=com.muslim.productive');
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Feedback',
            titlePadding: EdgeInsets.only(top: 8.h,  left: 12.w, bottom: 2.h),
            tiles: [
              SettingsTile(
                title: 'Report a problem',
                leading: const Icon(Icons.report_problem_outlined),
                onPressed: (BuildContext context) {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                    ),
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Column(
                            children: [
                              const Text('Write any issue',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: darkColor,
                                ),),
                              const Text('Please describe your issue that you noticed in app.'),
                              SizedBox(height: 14.h,),
                              TextField(
                                controller: reportCont,
                                autocorrect: true,
                                autofocus: true,
                                maxLines: 10,
                                minLines: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  hintText: 'Write Here...',
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: (){
                                      if(reportCont.text != ''){
                                        addData("Report", reportCont.text, DateTime.now());
                                      }else{
                                        Fluttertoast.showToast(msg: 'Write Something...', backgroundColor: Colors.redAccent, textColor: Colors.white);
                                      }
                                    },
                                    child: const Text('Submit',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  );
                },
              ),
              SettingsTile(
                title: 'Feedback',
                leading: const Icon(Icons.feedback_outlined),
                onPressed: (BuildContext context) {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                      ),
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Column(
                            children: [
                              const Text('Feedback',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: darkColor,
                                ),),
                              const Text('Your feedback is valuable to us. Please write your opinion.'),
                              SizedBox(height: 14.h,),
                              TextField(
                                controller: feedbackCont,
                                autocorrect: true,
                                autofocus: true,
                                maxLines: 10,
                                minLines: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  hintText: 'Write Here...',
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (){
                                    if(feedbackCont.text != ''){
                                      addData("Feedback", feedbackCont.text, DateTime.now());
                                    }else{
                                      Fluttertoast.showToast(msg: 'Write Something...', backgroundColor: Colors.purple, textColor: Colors.white);
                                    }
                                  },
                                  child: const Text('Submit',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  );
                },
              ),
              SettingsTile(
                title: 'Rate Us',
                leading: const Icon(Icons.star_border_outlined),
                onPressed: (BuildContext context) async{
                  await launch("market://details?id=com.muslim.productive");
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'About',
            titlePadding: EdgeInsets.only(top: 8.h,  left: 12.w, bottom: 2.h),
            tiles: [
              SettingsTile(
                title: 'About Us',
                leading: const Icon(Icons.account_box_outlined),
                onPressed: (BuildContext context) {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: waterColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network('https://crud.appworld.top/best_apk_zone.png',height: 100.r),
                                SizedBox(height: 12.h,),
                                const Text(aboutUs,
                                  style: TextStyle(
                                    color: darkColor,
                                  ),),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async{
                                  await launch('https://bestapkzone.com/');
                                },
                                child: const Text('Know More'),
                            )
                          ],
                        );
                      }
                  );
                },
              ),
              SettingsTile(
                title: 'Contact Us',
                leading: const Icon(Icons.mail_outline),
                onPressed: (BuildContext context) {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: waterColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Contact with',
                                  style: TextStyle(
                                    color: darkColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),),
                                SizedBox(height: 12.h,),
                                ListTile(
                                  title: const Text('E-mail'),
                                  leading: const Icon(Icons.email_outlined),
                                  minLeadingWidth: 0,
                                  onTap: ()async{
                                    launch('mailto:ratulhasan1644@gmail.com?subject=Productive Muslim');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Website'),
                                  leading: const Icon(Icons.public),
                                  minLeadingWidth: 0,
                                  onTap: () async{
                                    await launch('https://bestapkzone.com/');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Facebook'),
                                  leading: const Icon(Icons.facebook),
                                  minLeadingWidth: 0,
                                  onTap: () async{
                                    await launch('https://www.facebook.com/bestapkzone');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Youtube'),
                                  leading: const Icon(FontAwesomeIcons.youtube),
                                  minLeadingWidth: 0,
                                  onTap: () async{
                                    await launch('https://www.youtube.com/c/rhr-360');
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
              ),
              SettingsTile(
                title: 'View License',
                leading: const Icon(Icons.local_police_outlined),
                onPressed: (BuildContext context) {
                  showLicensePage(context: context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
