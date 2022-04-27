import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/FacultyFlow/FacultyHomePage.dart';
import 'package:splash_app/Pages/StudentHomePage.dart';
import 'package:splash_app/Pages/WelcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/utils/Dimensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();

  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? token = await storage.read(key: "token");
    String? type = await storage.read(key: "type");
    if(token != null && type == "student"){
      setState(() {
        page = StudentHomePage();
        print(storage);
      });
    }
    else if(token != null && type == "faculty"){
      setState(() {
        page = FacultyHomePage();
        print(storage);
      });
    }
    else if(token != null && type == "admin"){
      setState(() {
        page = AdminHomePage();
        print(storage);
      });
    }
    else{
      setState(() {
        page = WelcomePage();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: page
    );
  }
}
