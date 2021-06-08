import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merchant/functions/networkhelper.dart';
import 'package:merchant/widgets/textfield.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../size.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  StreamSubscription<DataConnectionStatus> listener;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool press = true;
  bool presstext = true;

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
                  textDirection: TextDirection.rtl,
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: Responsive.height(6, context)),
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //
            //
            //         child: Image.asset('assets/delivery.jpg',height: Responsive.height(30, context),)),
            //
            // ),
            SizedBox(
              height: Responsive.height(20, context),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Responsive.height(13, context)),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              textinput(
                                text: username,
                                seticon: Icon(Icons.person),
                                sec: false,
                                hint: "User Name",
                              ),
                              SizedBox(height: Responsive.height(2, context)),
                              textinput(
                                text: password,
                                seticon: Icon(Icons.lock),
                                sec: true,
                                hint: "Password",
                              ),
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
                                  setState(() {
                                    press = false;
                                    presstext = false;
                                  });
                                  SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();

                                  networkhelper networkhelpers = networkhelper(
                                      "https://delivery.dtc.iq/merchant/api_login", {
                                    "username": username.text,
                                    "password": password.text
                                  });
                                  var data = await networkhelpers.postdata();
                                  print(data);
                                  if (data == "no intrnet" ||
                                      data == "somethingerror") {
                                    _showMyDialog("تأكد من أتصال بالشبكة");
                                    setState(() {
                                      press = true;
                                      presstext = true;
                                    });
                                  } else {
                                    if (data["status"] == true) {
                                      _prefs.setString(
                                          "name", data["data"]["name"]);
                                      _prefs.setString(
                                          "token", data["data"]["token"]);
                                      _prefs.setString(
                                          "id", data["data"]["id"]);
                                      _prefs.setString("company_id", data["data"]["company_id"]);

                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/home',
                                              (Route<dynamic> route) => false);
                                    } else {
                                      _showMyDialog(
                                          "تأكد من المعلومات التي قمت بأدخالها");
                                      setState(() {
                                        press = true;
                                        presstext = true;
                                      });
                                    }
                                  }
                                } else {}
                              }
                            : null,
                        child: Container(
                          height: Responsive.height(8, context),
                          width: Responsive.width(75, context),
                          decoration: buttondecoration,
                          child: Center(
                            child: presstext
                                ? Text(
                                    "تسجيل الدخول",
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
    ));
  }
}
