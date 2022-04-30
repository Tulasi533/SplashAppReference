import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/Model/adminModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class UpdateCancelAdmin extends StatefulWidget {
  final String? adminId;
  const UpdateCancelAdmin({ Key? key, required this.adminId}) : super(key: key);

  @override
  State<UpdateCancelAdmin> createState() => _UpdateCancelAdminState();
}

class _UpdateCancelAdminState extends State<UpdateCancelAdmin> {
  final _globalkey = GlobalKey<FormState>();
  final NetworkHandler networkHandler = NetworkHandler();
  AdminModel adminModel = AdminModel();
  final storage = FlutterSecureStorage();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _college = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    var response = await networkHandler.get("/admin/getAdmin/${widget.adminId}");
    setState(() {
      adminModel = AdminModel.fromJson(response["data"][0]);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Form(
        key: _globalkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child:ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircleAvatar(
                    backgroundImage: NetworkHandler().getImage(adminModel.adminid.toString()),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  adminModel.adminid.toString(),
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFb8f5bc),
                    fontSize: 20
                  ),
                ),
              ),
              SizedBox(height: 20),
              nameTextField(),
              SizedBox(height: 25),
              mobileTextField(),
              SizedBox(height: 25),
              emailTextField(),
              SizedBox(height: 25),
              collegeTextField(),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async{
                      if(_globalkey.currentState!.validate()){
                        AdminModel adminModel1 = AdminModel(
                          name: _name.text, 
                          mobile: _mobile.text,
                          email: _email.text,
                          college: _college.text,
                        );
                        var response = await networkHandler.patch("/admin/updateAdmin/${adminModel.adminid}", adminModel1.ToJson());
                        print(response.body);
                        if(response.statusCode == 200 || response.statusCode == 201) {
                          final snackBar = SnackBar(
                            content: const Text("Admin Data Updated Successfully"),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context) => AdminHomePage()), 
                            (route) => false
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFA8F9AB),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "QuickSand",
                            fontSize: 20
                          ),
                        )
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFBFBF),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "QuickSand",
                            fontSize: 20
                          ),
                        )
                      ),
                    ),
                  ),
                ]
              )
            ]
          )
        )
      )
    );
  }

  Widget nameTextField(){
    _name.text = adminModel.name.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _name,
          validator: (value) {
            if(value!.isEmpty) {
              return "Admin Name can't be empty";
            }
            else if(value.length > 100){
              return "Admin Name length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin Name",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin Name",
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
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget mobileTextField(){
    _mobile.text = adminModel.mobile.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _mobile,
          validator: (value) {
            if(value!.isEmpty) {
              return "Mobile Number can't be empty";
            }
            else if(value.length > 100){
              return "Mobile Number length should be 10";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Mobile Number",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Mobile Number",
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
          maxLength: 10,
          maxLines: null,
        )
      ],
    );
  }

  Widget emailTextField(){
    _email.text = adminModel.email.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _email,
          validator: (value) {
            if(value!.isEmpty) {
              return "Admin Email can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin Email",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin Email",
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

  Widget collegeTextField(){
    _college.text = adminModel.college.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _college,
          validator: (value) {
            if(value == null) {
              return "Admin College can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin College",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin College Name",
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
}