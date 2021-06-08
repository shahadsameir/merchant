import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'displayhome.dart';
import 'login.dart';

class startscreen extends StatelessWidget {
  Future<String> getuser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return _prefs.getString("name");

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getuser(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ));
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else {
                if (snapshot.hasData) {
                  return  displayhome();
                }
                return  login();

              }
          }
        });
  }
}
