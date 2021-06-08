import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../size.dart';

class textfieldedit extends StatelessWidget {
  final myVaild;
  final int line;
  final TextEditingController text;
  final bool autovalidateMode;
  const textfieldedit(
      {@required this.myVaild,
      @required this.text,
      @required this.autovalidateMode,
      @required this.line});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: Responsive.width(80, context),
        child: TextFormField(
          maxLines:line,
          autovalidateMode: autovalidateMode
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          style: TextStyle(color: Colors.black),
          validator: myVaild,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            fillColor: Color(0xfff3f3f3),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                vertical:Responsive.height(3, context), horizontal: 20.0),
            border: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 2,
                )),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'OpenSans',
            ),
          ),
          controller: text,
        ),
      ),
    );
  }
}

class titletext extends StatelessWidget {
  final String title;
  const titletext({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      ),
    );
  }
}

class inputnumber extends StatelessWidget {

  final TextEditingController text;
  final myVaild;
  final bool autovalidateMode;
  const inputnumber(
      { this.myVaild, this.text, this.autovalidateMode});
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: Responsive.width(80, context),
        child: TextFormField(
          autovalidateMode: autovalidateMode?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
          validator: myVaild,


          controller: text,
          maxLength: 9,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],


          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            fillColor: Color(0xfff3f3f3),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                vertical:Responsive.height(3, context), horizontal: 20.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  width: 2,
                )),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'OpenSans',
            ),
            prefixIcon: Container(
                decoration: new BoxDecoration(

                  border: Border(
                    right: BorderSide(
                        width: 0.5, color: Colors.grey),
                  ),
                ),

                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "07",

                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 16,

                      ),
                    ))),
          ),
        ),
      ),
    );
  }
}

class inputnumbertext extends StatelessWidget {
  final String Hint;
  final TextEditingController text;
  final myVaild;


  final bool autovalidateMode;
  const inputnumbertext(
      {this.Hint, this.myVaild, this.text,this.autovalidateMode});
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Responsive.width(80, context),
      child: TextFormField(

        autovalidateMode: autovalidateMode?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        validator: myVaild,

        controller: text,

        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],

        keyboardType: TextInputType.number,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          fillColor: Color(0xfff3f3f3),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              vertical:Responsive.height(3, context), horizontal: 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 2,
              )),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
