import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merchant/functions/networkhelper.dart';
import 'package:merchant/widgets/textfield.dart';
import '../size.dart';
import 'editorder.dart';

class Details extends StatefulWidget {
  final String name;
  final String recivename;
  final String recive_phone;
  final String region;
  final String location;
  final String des;
  final String id;
  final String amount;
  final int statusid;
  final String token;
  final String price;
  final String status;

  Details(
      {this.des,
      this.name,
      this.recive_phone,
      this.recivename,
      this.location,
      this.region,
      this.id,
      this.amount,
      this.statusid,
      this.token,
      this.price,
        this.status
     });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool press = true;
  bool presstext = true;
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  var date;
  var token;
  showSnackBar(String text) {
    scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(0xffa6c5f7),
    ));
  }

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
                SizedBox(height: Responsive.height(5, context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        child: GestureDetector(
                      onTap: () async {
                       Navigator.pop(context);
                      },
                      child: Container(
                        height: Responsive.height(7, context),
                        width: Responsive.width(14, context),
                        decoration: buttondecoration,
                        child: Center(
                          child: presstext
                              ? Text(
                                  "كلا",
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
                    SizedBox(width: Responsive.width(3, context)),
                    Container(
                        child: GestureDetector(
                      onTap: () async {
                        networkhelper networkhelpers = networkhelper(
                            "https://delivery.dtc.iq/merchant/api_delete?order_id=${widget.id}",
                            {
                              "token": widget.token,
                            });
                        var data = await networkhelpers.postdata();
                        print(data);
                        if (data == "no intrnet" || data == "somethingerror") {
                          showSnackBar("تأكد من أتصال بالشبكة");
                          Navigator.pop(context);
                        } else {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                              '/home',
                                  (Route<dynamic> route) => false);
                        }
                      },
                      child: Container(
                        height: Responsive.height(7, context),
                        width: Responsive.width(14, context),
                        decoration: buttondecoration,
                        child: Center(
                          child: presstext
                              ? Text(
                                  "نعم",
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
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      key: scaffoldState,

      appBar: new AppBar(
        title: Text(
          "معلومات الطلب",
          style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xfffbfdfe)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4696ec),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Align(
                //     alignment: Alignment.topCenter,
                //     child: Hero(
                //         tag: widget.index,
                //         child: Image.asset(
                //           'assets/delivery.jpg',
                //           height: Responsive.height(30, context),
                //         )),
                //   ),
                // ),
                SizedBox(height: Responsive.height(5, context)),
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 10.0),
                //     child: Text(widget.name,
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 20,
                //         )),
                //   ),
                // ),
                // SizedBox(height: Responsive.height(1, context)),
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     width: MediaQuery.of(context).size.width - 50.0,
                //     child: Text(widget.des,
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w600,
                //             color: Color(0xFF838B96))),
                //   ),
                // ),
                // SizedBox(height: Responsive.height(2, context)),
                detail(
                  text: widget.name,
                  title: "أسم العنصر : ",
                  icon: Icons.drive_file_rename_outline,
                ),
                detail(
                  text: widget.des,
                  title: "الوصف : ",
                  icon: Icons.description,
                ),
                detail(
                  text: widget.recivename,
                  title: "اسم المستلم : ",
                  icon: Icons.person,
                ),
                detail(
                  text: widget.recive_phone,
                  title: " رقم المستلم : ",
                  icon: Icons.phone,
                ),

                detail(
                  text: widget.location,
                  title: " الموقع : ",
                  icon: Icons.location_on,
                ),
                detail(
                  text: widget.region,
                  title: " أقرب نقطه داله : ",
                  icon: Icons.location_city,
                ),
                detail(
                  text: widget.amount,
                  title: " الكميه : ",
                  icon: Icons.format_list_numbered_rtl,
                ),
                detail(
                  text: widget.price,
                  title: "السعر : ",
                  icon: Icons.monetization_on,
                ),
                detail(
                  text: widget.status,
                  title: "الحاله : ",
                  icon: Icons.delivery_dining,
                ),
                SizedBox(height: Responsive.height(2, context)),
                widget.statusid == 1
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Container(
                          child: GestureDetector(
                          onTap: () {_showMyDialog("حذف الطلب");},
                          child: Container(
                            height: Responsive.height(7, context),
                            width: Responsive.width(22, context),
                            decoration: buttondecoration,
                            child: Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.delete,
                                        color:Colors.white,
                                        size: Responsive.width(5, context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        "حذف",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],

                                )
                            ),
                          ),
                        )),
                              SizedBox(width: Responsive.width(5, context)),
                              Container(
                                  child: GestureDetector(
                                    onTap: () {  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => edit(
                                              des:widget.des,
                                              location:widget.region,
                                              amount:widget.amount,
                                              name: widget.name,
                                              recivename: widget.recivename,
                                              recive_phone:widget.recive_phone,
                                              id:widget.id,
                                              price:widget.price,
                                              token: token,
                                            )));},
                                    child: Container(
                                      height: Responsive.height(7, context),
                                      width: Responsive.width(22, context),
                                      decoration: buttondecoration,
                                      child: Center(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Icon(
                                                  Icons.edit,
                                                  color:Colors.white,
                                                  size: Responsive.width(5, context),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Text(
                                                  "تعديل",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],

                                          )
                                      ),
                                    ),
                                  )),

                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(height: Responsive.height(2, context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class detail extends StatelessWidget {
  const detail(
      {Key key, @required this.text, @required this.title, @required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color:Color(0xff4696ec),
            size: 20,
          ),
          SizedBox(
            width: 2,
          ),
          Expanded(
            child: Text(

              title,
              style: TextStyle(fontSize: 20,),

            ),
          ),

          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
              textAlign:
              TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
