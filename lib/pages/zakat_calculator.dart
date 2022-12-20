import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/colors.dart';
import 'package:productive_muslim/widgets/zakat_text_field.dart';

class ZakatCalculator extends StatefulWidget {
  const ZakatCalculator({Key? key}) : super(key: key);

  @override
  State<ZakatCalculator> createState() => _ZakatCalculatorState();
}

class _ZakatCalculatorState extends State<ZakatCalculator> {
  double totalamount = 0.0;
  double zakat = 0.0;
  double income = 0.0;
  double debt = 0.0;

  TextEditingController netAmountCont = TextEditingController();
  TextEditingController bankCont = TextEditingController();
  TextEditingController goldCont = TextEditingController();
  TextEditingController silverCont = TextEditingController();
  TextEditingController investCont = TextEditingController();
  TextEditingController propertyCont = TextEditingController();
  TextEditingController buisnessCont = TextEditingController();
  TextEditingController othersCont = TextEditingController();

  TextEditingController debtCreditcard = TextEditingController();
  TextEditingController debtBuisness = TextEditingController();
  TextEditingController debtPersonal = TextEditingController();
  TextEditingController debtOthers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
        shadowColor: waterColor,
        elevation: 4,
        title: Text('যাকাত ক্যালকুলেটর',
          style: TextStyle(
            color: Colors.black87
          ),),
        actions: [
          IconButton(
              onPressed: (){
                FlutterClipboard.copy(
                    'মোট সম্পদঃ ${income}'
                    '\nমোট ঋণঃ ${debt}'
                    '\nসর্বমোটঃ ${totalamount}'
                    '\n\nযাকাত হয়েছেঃ ${zakat}'
                ).then((value) {
                  Fluttertoast.showToast(msg: 'হিসাব কপি করা হয়েছে', textColor: Colors.white, backgroundColor: Colors.red);
                });
              },
              icon: Icon(Icons.copy)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 14, right: 14, left: 14),
        child: ListView(
          shrinkWrap: true,
          primary: true,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      zColor,
                      primaryColor
                    ]
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('মোট সম্পদঃ',
                          style: TextStyle(
                            fontFamily: 'Bangla',
                            color: Colors.white,
                            fontSize: 16
                          ),),
                        Text(income.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('মোট ঋণঃ',
                          style: TextStyle(
                              fontFamily: 'Bangla',
                              color: Colors.white,
                              fontSize: 16
                          ),),
                        Text(debt.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('সর্বমোটঃ',
                          style: TextStyle(
                              fontFamily: 'Bangla',
                              color: Colors.white,
                              fontSize: 16
                          ),),
                        Text(totalamount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                    Divider(color: Colors.white,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('যাকাত হয়েছেঃ',
                          style: TextStyle(
                            fontFamily: 'Bangla',
                            color: Colors.limeAccent,
                            fontSize: 16
                          ),),
                        Text(zakat.toString(),
                          style: TextStyle(
                            color: Colors.limeAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18,),
            const Text('অর্থঃ',
              style: TextStyle(
                color: zColor,
                fontSize: 18
              ),),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Column(
                children: [
                  ZakatTextField(
                    controller: netAmountCont,
                    title: 'নগদ টাকা',
                  ),
                  SizedBox(height: 7,),
                  ZakatTextField(
                    controller: bankCont,
                    title: 'ব্যাংক একাউন্টে অর্থ',
                  ),
                  SizedBox(height: 10,),
                  ZakatTextField(
                    controller: goldCont,
                    title: 'সোনার মান (টাকায়)',
                  ),
                  SizedBox(height: 7,),
                  ZakatTextField(
                    controller: silverCont,
                    title: 'রুপার মান (টাকায়)',
                  ),
                  SizedBox(height: 10,),
                  ZakatTextField(
                    controller: investCont,
                    title: 'বিনিয়োগ',
                  ),
                  SizedBox(height: 7,),
                  ZakatTextField(
                    controller: propertyCont,
                    title: 'সম্পত্তি',
                  ),
                  SizedBox(height: 7,),
                  ZakatTextField(
                    controller: buisnessCont,
                    title: 'ব্যবসায়িক পণ্য',
                  ),
                  SizedBox(height: 10,),
                  ZakatTextField(
                    controller: othersCont,
                    title: 'অন্যান্য',
                  ),
                ],
              ),
            ),
        SizedBox(height: 16,),
        const Text('ঋণঃ',
          style: TextStyle(
              color: Colors.red,
              fontSize: 18
          ),),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
          ),
          child: Column(
            children: [
              ZakatTextField(
                controller: debtCreditcard,
                title: 'ক্রেডিট কার্ড পেমেন্ট',
              ),
              SizedBox(height: 7,),
              ZakatTextField(
                controller: debtBuisness,
                title: 'ব্যবসায়িক ঋণ',
              ),
              SizedBox(height: 7,),
              ZakatTextField(
                controller: debtPersonal,
                title: 'ব্যক্তিগত ঋণ',
              ),
              SizedBox(height: 10,),
              ZakatTextField(
                controller: debtOthers,
                title: 'অন্যান্য',
              ),
            ],
          ),
        ),

            SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.all(4),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                height: 50,
                onPressed: (){
                  check(TextEditingController t){
                    if(t.text == ''){
                      return '0';
                    }
                    return t.text;
                  }

                  double total = double.parse(check(netAmountCont)) + double.parse(check(bankCont)) + double.parse(check(goldCont)) + double.parse(check(silverCont)) +
                    double.parse(check(investCont)) +double.parse(check(propertyCont)) + double.parse(check(buisnessCont))+double.parse(check(othersCont));

                  double debtTotal = double.parse(check(debtCreditcard)) + double.parse(check(debtBuisness)) + double.parse(check(debtPersonal)) + double.parse(check(debtOthers));
                  setState(() {
                    double subtotal = total - debtTotal;
                    income = total;
                    debt = debtTotal;
                    totalamount = subtotal;
                    zakat = subtotal*2.5/100;
                  });
                },
                color: zColor,
                child: Text('হিসাব করুন',
                  style: TextStyle(
                    fontFamily: 'Bangla',
                    color: Colors.white,
                    fontSize: 19,
                  ),),
              ),
            ),
            SizedBox(height: 18,),

          ],
        ),
      ),
    );
  }
}
