import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminChangePasswordPage.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({ Key? key }) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _adminidcontroller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF09488D),
      body: Form(
        key: _globalkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You are one step to Kick Out🥳",
                style: TextStyle(
                  fontFamily: "MarckScript",
                  fontSize: 25,
                  color: Color(0xFFBAC3F0)
                ),
              ),
              SizedBox(height: 50),
              adminidTextField(),
              SizedBox(height: 40),
              passwordTextField(),
              SizedBox(height:40),
              InkWell(
                onTap: () async{
                  setState(() {
                    circular = true;
                  });
                  Map<String, String> data = {
                    "adminid": _adminidcontroller.text,
                    "password": _passwordController.text
                  };
                  var response = await networkHandler.post("/admin/login", data);
                  if(response.statusCode == 200 || response.statusCode == 201) {
                    Map<String, dynamic> output = json.decode(response.body);
                    print(output["token"]);
                    print(output["type"]);
                    await storage.write(key: "token", value: output["token"]);
                    await storage.write(key: "type", value: output["type"]);
                    setState(() {
                      validate = true;
                      circular = false;
                    });
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => AdminHomePage()
                      ),
                      (route) => false
                    );
                  }
                  else {
                    String output = json.decode(response.body);
                    setState(() {
                      validate = false;
                      errorText = output;
                      circular = false;
                    });
                  }
                  
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFCCD2F5)
                  ),
                  child: Center(
                    child: circular? CircularProgressIndicator() : Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  )
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => AdminChangePasswordPage())
                  );
                },
                child: Text(
                  "Change/Forget Password?",
                  style: TextStyle(
                    color: Color(0xFFbdfcc5),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget adminidTextField() {
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _adminidcontroller,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            labelText: "Admin ID",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin ID in all CAPITALS",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
        )
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility, color: Colors.lightBlueAccent,),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            labelText: "Password",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
        )
      ],
    );
  }
}