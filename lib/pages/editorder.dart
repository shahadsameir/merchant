import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merchant/functions/networkhelper.dart';
import 'package:merchant/widgets/textfield.dart';
import 'package:merchant/widgets/textfieldofitem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import '../size.dart';

class edit extends StatefulWidget {
  final String name;
  final String recivename;
  final String recive_phone;

  final String location;
  final String des;
  final String id;
  final String amount;
  final int status;
  final String token;
  final String price;
  edit(
      {this.des,
        this.name,
        this.recive_phone,
        this.recivename,
        this.location,

        this.id,
        this.amount,
        this.status,
        this.token,
      this.price});

  @override
  _editState createState() => _editState();
}

class _editState extends State<edit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController des = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController R_name = new TextEditingController();
  TextEditingController R_address = new TextEditingController();
  TextEditingController R_phone = new TextEditingController();
  TextEditingController price = new TextEditingController();
  bool press = true;
  bool presstext = true;
  String selectedRegion = null;
  String selectedtype = null;

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: Responsive.height(1, context),
                ),
                Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
@override
  void initState() {
  name.text = widget.name;
 des.text = widget.des;
 amount.text =widget.amount;
 R_name.text =widget.recivename;
 R_address.text = widget.location;
  R_phone.text = widget.recive_phone;
  price.text = widget.price;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "اضافة عنصر جديد",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4696ec),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Responsive.height(1, context)),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                titletext(
                                  title: "أسم عنصر",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                textfieldedit(
                                  line: 1,
                                  text: name,
                                  myVaild: (val) => val.length <= 0
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  autovalidateMode: true,
                                ),
                                SizedBox(height: Responsive.height(1, context)),
                                titletext(
                                  title: "الوصف",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                textfieldedit(
                                  line: 5,
                                  text: des,
                                  myVaild: (val) => val.length <= 0
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  autovalidateMode: true,
                                ),
                                SizedBox(height: Responsive.height(1, context)),
                                titletext(
                                  title: "الكميه",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                inputnumbertext(

                                  text: amount,
                                  myVaild: (val) => val.length <= 0
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  autovalidateMode: true,
                                ),
                                SizedBox(height: Responsive.height(1, context)),
                                SizedBox(height: Responsive.height(1, context)),
                                titletext(
                                  title: "السعر",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                inputnumbertext(
                                  text: price,
                                  myVaild: (val) => val.length <= 0
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  autovalidateMode: true,
                                ),
                                SizedBox(height: Responsive.height(1, context)),
                                titletext(
                                  title: "أسم المستلم",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                textfieldedit(
                                  line: 1,
                                  text: R_name,
                                  myVaild: (val) => val.length <= 0
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  autovalidateMode: true,
                                ),
                                SizedBox(height: Responsive.height(1, context)),
                                titletext(
                                  title: "رقم هاتف المستلم",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                inputnumber(

                                  autovalidateMode: false,
                                  myVaild: (val) =>
                                  val.length != 9
                                      ? " تأكد من الرقم"
                                      : null,
                                  text: R_phone,
                                ),

                                SizedBox(height: Responsive.height(1, context)),
                                titletext(
                                  title: "أقرب نقطه داله",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                textfieldedit(
                                  line: 1,
                                  text: R_address,
                                  myVaild: (val) => val.length <= 0
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  autovalidateMode: true,
                                ),
                                SizedBox(height: Responsive.height(1, context)),

                                titletext(
                                  title: "النوع",
                                ),
                                SizedBox(height: Responsive.height(2, context)),
                                Container(
                                  width: Responsive.width(80, context),
                                  height: Responsive.height(8, context),
                                  padding: EdgeInsets.fromLTRB(10, 2, 15, 2),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 0)),
                                  child: Directionality(
                                    textDirection: ui.TextDirection.rtl,
                                    child: DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                            hint: new Text("اختار النوع"),
                                            value: selectedtype,
                                            isDense: true,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                selectedtype = newValue;
                                              });
                                              print(selectedtype);
                                            },
                                            items: type.map((data) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: data["id"],
                                                child: Container(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: new Text(data["value"],
                                                      textAlign: TextAlign.right,
                                                      style: new TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              );
                                            }).toList())),
                                  ),
                                ),
                                // SizedBox(height: Responsive.height(1, context)),
                                // titletext(
                                //   title: "المنطقة",
                                // ),
                                // SizedBox(height: Responsive.height(2, context)),
                                // Container(
                                //   width: Responsive.width(80, context),
                                //   height: Responsive.height(8, context),
                                //   padding: EdgeInsets.fromLTRB(10, 2, 15, 2),
                                //   decoration: BoxDecoration(
                                //       color: Color(0xffEBF5FB),
                                //       borderRadius: BorderRadius.circular(5),
                                //       border: Border.all(
                                //           color: Colors.grey, width: 0)),
                                //   child: Directionality(
                                //     textDirection: ui.TextDirection.rtl,
                                //     child: DropdownButtonHideUnderline(
                                //         child: new DropdownButton<String>(
                                //             hint: new Text("تحديد المنطقة"),
                                //             value: selectedRegion,
                                //             isDense: true,
                                //             onChanged: (String newValue) {
                                //               setState(() {
                                //                 selectedRegion = newValue;
                                //               });
                                //               print(selectedRegion);
                                //             },
                                //             items: region.map((data) {
                                //               return new DropdownMenuItem<
                                //                   String>(
                                //                 value: data["id"],
                                //                 child: Container(
                                //                   alignment:
                                //                   Alignment.centerRight,
                                //                   child: new Text(data["value"],
                                //                       style: new TextStyle(
                                //                           color: Colors.black)),
                                //                 ),
                                //               );
                                //             }).toList())),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.height(4, context)),
                        Container(
                            child: GestureDetector(
                              onTap: press
                                  ? () async {
                                if (_formKey.currentState.validate()) {
                                  if (
                                      selectedtype == null ) {
                                    _showMyDialog("الرجاء ادخال باقي الحقول");
                                  } else {
                                    setState(() {
                                      press = false;
                                    });
                                    SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                    var id = _prefs.getString("id");
                                    var company_id = _prefs.getString("company_id");
                                    var token = _prefs.getString("token");
                                    print(id);
                                    print(company_id);
                                    networkhelper networkhelpers = networkhelper(
                                        "https://delivery.dtc.iq/merchant/api_edit?order_id=${widget.id}",
                                        {
                                          "name": name.text,
                                          "amount": amount.text,
                                          "description": des.text,
                                          "receiver_name": R_name.text,
                                          "receiver_mobile": R_phone.text,
                                          "receiver_address": R_address.text,
                                          "type": selectedtype,
                                          "token": token,
                                          "price": price.text

                                        });
                                    var data =
                                    await networkhelpers.postdata();
                                    print(data);
                                    if (data == "no intrnet" ||
                                        data == "somethingerror") {
                                      _showMyDialog("تأكد من أتصال بالشبكة");
                                      setState(() {
                                        press = true;
                                      });
                                    } else {
                                      if (data["status"] == true) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            '/home',
                                                (Route<dynamic> route) =>
                                            false);
                                      } else {
                                        _showMyDialog(
                                            "حدث مشكله في الشبكه الرجاء محاوله لاحقا");
                                        setState(() {
                                          press = true;
                                        });
                                      }
                                    }
                                  }
                                }
                              }
                                  : null,
                              child: Container(
                                height: Responsive.height(8, context),
                                width: Responsive.width(75, context),
                                decoration: buttondecoration,
                                child: Center(
                                  child: presstext
                                      ? Text(
                                    "تعديل",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  )
                                      : SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: Responsive.height(10, context)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var type = [
    {"id": "1", "value": "ظرف ورقي(0.5kg)"},
    {"id": "2", "value": "علبة صغيرة(1kg)"},
    {"id": "3", "value": "صندوق وسط(1kg-5kg)"},
    {"id": "4", "value": "صندوق كبير(5kg-20kg)"}
  ];
  var region = [
    {"id": "1", "value": "شارع فلسطين"},
    {"id": "2", "value": "الحارثية"},
    {"id": "3", "value": "الكرادة"},
    {"id": "4", "value": "البلديات"},
    {"id": "5", "value": "البنوك"},
    {"id": "6", "value": "السعدون"},
    {"id": "7", "value": "الاعظمية"},
    {"id": "8", "value": " شارع المغرب"},
    {"id": "9", "value": "حي القاهرة"},
    {"id": "10", "value": "كرادة مريم"},
    {"id": "11", "value": "الكاظمية"},
    {"id": "12", "value": "المنصور"},
    {"id": "13", "value": "الغزالية"},
    {"id": "14", "value": "العطيفية"},
    {"id": "15", "value": "وشاش"},
    {"id": "16", "value": "اسكان"},
    {"id": "17", "value": "حي العدل"},
    {"id": "18", "value": "يرموك"},
    {"id": "19", "value": "عامرية"},
    {"id": "20", "value": "بياع"},
    {"id": "21", "value": "حي الجامعة"},
    {"id": "22", "value": "الدورة"},
    {"id": "23", "value": "زعفرانية"},
    {"id": "24", "value": "المشتل"},
    {"id": "25", "value": "مدينة الصدر"},
    {"id": "26", "value": "حي تونس"},
    {"id": "27", "value": "حي القاهرة"},
    {"id": "28", "value": "المستنصرية"},
    {"id": "29", "value": "زيونة"},
    {"id": "30", "value": "بغداد الجديدة"},
    {"id": "31", "value": "نفق الشرطة"},
    {"id": "32", "value": "الطالبية"},
    {"id": "33", "value": "جكوك"},
    {"id": "34", "value": "شارع حيفا"},
    {"id": "35", "value": "شارع سلمان فايق"},
    {"id": "36", "value": "الامين"},
    {"id": "37", "value": "حي الجهاد"},
    {"id": "38", "value": "السيدية"},
    {"id": "39", "value": "الشعلة"},
    {"id": "40", "value": "حي اور"},
    {"id": "41", "value": "صليخ /الستمية"},
    {"id": "42", "value": "القادسية"},
    {"id": "43", "value": "الشعب"},
    {"id": "44", "value": "الحرية"},
    {"id": "45", "value": "حي العامل"},
    {"id": "46", "value": "الطوبجي"},
    {"id": "47", "value": "حي الخضراء"},
  ];
  var date = null;
}
