import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merchant/functions/networkhelper.dart';
import 'package:merchant/pages/searchwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../size.dart';
import 'detailspage.dart';

class displayhome extends StatefulWidget {
  @override
  _displayhomeState createState() => _displayhomeState();
}

class _displayhomeState extends State<displayhome> {
  var data = [];
  var check = "waiting";
  var token;
  bool press = true;
  getorder() async {
    setState(() {
      press = false;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString("token");
    var id = _prefs.getString("id");
    networkhelper network = new networkhelper(
        "https://delivery.dtc.iq/merchant/api_home?id=$id", {"token": token});
    var res = await network.postdata();
    print(res);
    if (res == "no intrnet" || res == "somethingerror") {
      if (mounted) {
        setState(() {
          data = [];
          check = "no";
        });
      }
    } else {
      if (res["status"] == true) {
        if (mounted) {
          setState(() {
            data = res["data"];
            if (data.length == 0) {
              setState(() {
                check = "no data";
              });
            }
          });
        }
      }
    }
    if (mounted) {
      setState(() {
        press = true;
      });
    }
  }

  checkw() {
    if (check == "no") {
      return Column(
        children: [
          SizedBox(height: Responsive.height(10, context)),
          Center(
              child: Text(
            "لا يوجد أتصال بالشبكة",
            style: TextStyle(fontSize: 20),
          ))
        ],
      );
    } else if (check == "no data") {
      return Column(
        children: [
          SizedBox(height: Responsive.height(10, context)),
          Center(
              child: Text(
            "لا يوجد بيانات",
            style: TextStyle(fontSize: 20),
          ))
        ],
      );
    } else {
      return SizedBox(
        width: 0,
      );
    }
  }

  @override
  void initState() {
    getorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff4696ec),
        title: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Text(
            "الطلبات",
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xfffbfdfe)),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
                onTap: press
                    ? () {
                        getorder();
                      }
                    : null,
                child: press
                    ? Icon(
                        Icons.refresh,
                        color: Color(0xfffbfdfe),
                        size: Responsive.width(7, context),
                      )
                    : SpinKitRing(
                        color: Color(0xfffbfdfe),
                        size: Responsive.height(4, context),
                      )),
          ),
          Padding(
              padding: EdgeInsets.only(right: 13.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => webview(token: token)));
                },
                child: Icon(
                  Icons.search,
                  color: Color(0xfffbfdfe),
                  size: 26.0,
                ),
              )),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 10,
          child: new Icon(Icons.add),
          backgroundColor: Color(0xff4696ec),
          onPressed: () {
            Navigator.pushNamed(context, '/newitem');
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // SizedBox(height: Responsive.height(1, context)),
            data.length == 0
                ? checkw()
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        DataTable(
                          showBottomBorder: false,
                          dividerThickness: 1,
                          headingRowColor:
                              MaterialStateColor.resolveWith((states) {
                            return Color(0xffffffff);
                          }),
                          columnSpacing: Responsive.width(14, context),
                          dataRowHeight: 50,
                          dataRowColor:
                              MaterialStateColor.resolveWith((states) {
                            return Color(0xfffbfdfe);
                          }),
                          showCheckboxColumn: false,
                          columns: [
                            DataColumn(
                                label: Text(
                              "أسم العنصر",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text("أسم المستلم",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14)),
                            )),
                            DataColumn(
                                label: Text("المنطقة",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14),
                                    textAlign: TextAlign.center)),
                          ],
                          rows: data
                              .map(
                                ((element) => DataRow(
                                      color: MaterialStateColor.resolveWith(
                                        (states) {
                                          if (data.indexOf(element) % 2 == 0) {
                                            return Color(0xfff3f3f3);
                                          } else {
                                            return Color(0xffffffff);
                                          }
                                        },
                                      ),
                                      onSelectChanged: (bool selected) {
                                        if (selected) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                        des: element[
                                                            "description"],
                                                        location:
                                                            element["region"],
                                                        region: element[
                                                            "receiver_address"],
                                                        amount:
                                                            element["amount"],
                                                        name: element["name"],
                                                        recivename: element[
                                                            "receiver_name"],
                                                        recive_phone: element[
                                                            "receiver_mobile"],
                                                        id: element["id"],
                                                        statusid: int.parse(
                                                            element[
                                                                "status_id"]),
                                                        token: token,
                                                        price: element["price"],
                                                    status: element["status"],
                                                      )));
                                        }
                                      },
                                      cells: <DataCell>[
                                        DataCell(
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: Responsive.width(
                                                      20, context),
                                                  child: Text(
                                                    element["name"],
                                                    textAlign: TextAlign.right,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff505050),
                                                        fontSize: 12),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ), //Extracting from Map element the value
                                        DataCell(Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: Responsive.width(
                                                    20, context),
                                                child: Center(
                                                  child: Text(
                                                    element["receiver_name"],
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff505050),
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                        DataCell(Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: Responsive.width(
                                                    15, context),
                                                child: Text(
                                                  element["region"],
                                                  textAlign: TextAlign.right,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Color(0xff505050),
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    )),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: Responsive.height(1, context)),
          ],
        ),
      ),
    );
  }
}
