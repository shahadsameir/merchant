
import 'package:flutter/material.dart';

import '../size.dart';

class textinput extends StatelessWidget {
  const textinput({
    Key key,
    @required this.text,
    @required this.seticon,
    @required this.sec,
    @required this.hint
  }) : super(key: key);
  final bool sec;
  final String hint;
  final TextEditingController text;
  final Icon seticon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(90, context),
      //  height: Responsive.height(10, context) ,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText:sec,
        validator: (val) =>
        val.length <= 0 ? "This field is required" : null,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red,fontSize: 16),
          prefixIcon: seticon,
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                color: Colors.grey,
                width:1,
              )),
          enabledBorder: const OutlineInputBorder(
            borderSide:
            const BorderSide(color: Colors.grey, width: 1),
          ),

          hintText:hint,
          hintStyle: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans',
              color: Colors.grey),
        ),
        textAlign: TextAlign.left,
        controller: text,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}

var buttondecoration=BoxDecoration(
  color: Color(0xff4696ec),
  borderRadius: BorderRadius.all(Radius.circular(7.0)),
);