import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/NetworkHandler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splash_app/Model/studentModel.dart';
import 'package:splash_app/Pages/MentorPage.dart';
import 'package:splash_app/Pages/WelcomePage.dart';
class MenuPage extends StatefulWidget {
  const MenuPage({ Key? key }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final NetworkHandler networkHandler = NetworkHandler();
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  StudentModel studentModel = StudentModel();
  bool circular = true;
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/student/getData");
    setState(() {
      studentModel = StudentModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      body: circular ? Center(child: CircularProgressIndicator()) : ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          imageProfile(),
          SizedBox(height: 10),
          Divider(
            thickness: 2.0,
            color: Colors.white30,
          ),
          SizedBox(height: 5),
          otherDetails("Name", studentModel.name.toString()),
          otherDetails("Email", studentModel.email.toString()),
          otherDetails("Mobile", studentModel.mobile.toString()),
          otherDetails("Branch", studentModel.branch.toString()),
          otherDetails("College", studentModel.college.toString()),
          SizedBox(height: 5),
          Divider(
            thickness: 2.0,
            color: Colors.white30,
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context)=> MentorPage()
                      )
                    );
                  },
                  child: Text(
                    "My Mentor",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: logout,
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
  Widget imageProfile() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: _imageFile == null? NetworkHandler().getImage(studentModel.regno.toString()): FileImage(File(_imageFile!.path)) as ImageProvider
                // _imageFile == null? null : FileImage(File(_imageFile!.path)),
                // FileImage(File(_imageFile.path))
                // NetworkHandler().getImage(studentModel.regno.toString())
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () async{
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder)=> bottomSheet())
                      
                    );
                    
                  },
                  child:Icon(
                    Icons.camera_alt,
                    color: Colors.lightBlue,
                    size: 28,
                  ),
                )
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            studentModel.regno.toString(),
            style: TextStyle(
              color: Color(0xFFB3F6A8),
              fontSize: 20,
              fontFamily: "QuickSand",
              letterSpacing: 2,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10)
        ]
      )
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                }, 
                icon: Icon(Icons.camera), 
                label: Text("Camera")
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                }, 
                icon: Icon(Icons.image), 
                label: Text("Gallery")
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState((){
      _imageFile = pickedFile;
      
    });
    if(_imageFile != null) {
      var imageResponse = await networkHandler.patchImage("/student/add/image", _imageFile!.path);
    }
    
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label :",
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD1F7FF),
              fontFamily: "QuickSand"
            ),
          ),
          SizedBox(width: 5),
          Expanded(child: Text(
            value,
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFFFFE0E6),
              fontFamily: "QuickSand",
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis
            ),
          )
          )
        ],
      )
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> WelcomePage()), (route) => false);
  }
}