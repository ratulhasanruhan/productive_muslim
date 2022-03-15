import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  bool nointernet;
  Loader({this.nointernet = false});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/loader.json',width: 200.w),
          SizedBox(height: 20.w,),
          Visibility(
            visible: nointernet,
            child: Text('Please check your Internet!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
