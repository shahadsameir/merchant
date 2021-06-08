import 'package:merchant/pages/addnewitem.dart';
import 'package:merchant/pages/displayhome.dart';
import 'package:merchant/pages/login.dart';
import 'package:merchant/pages/startscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'merchant',
      theme: ThemeData(
        fontFamily: "Tajawal-Regular",
        scaffoldBackgroundColor:Color(0xfffbfdfe),

      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new displayhome(),
        '/newitem': (BuildContext context) => new newitem(),
        // '/BottonNBarC':(BuildContext context) => new BottonNBarC(),
        '/login': (BuildContext context) => new login(),
      },
      home: startscreen(),
    );
  }
}
