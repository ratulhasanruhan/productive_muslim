import 'package:flutter/material.dart';
import '../constant.dart';

class ZakatTextField extends StatelessWidget {
  String title;
  TextEditingController controller;
  ZakatTextField({Key? key, required this.title, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
          flex: 1,
        ),
        Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: deepColor,
                          width: 0.5
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: deepColor,
                          width: 1
                      )
                  ),
                  prefixIcon:Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text('৳',
                        style: TextStyle(
                            color: zColor
                        ),)
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  isDense: true,
                  hintText: '0000.0'
              ),
            )
        )
      ],
    );
  }
}
