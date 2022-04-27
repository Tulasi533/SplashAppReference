import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/ManageAdmin/AddAdminPage.dart';
import 'package:splash_app/AdminFlow/ManageAdmin/DeleteAdminPage.dart';
import 'package:splash_app/AdminFlow/ManageAdmin/UpdateAdminPage.dart';

class ManageAdminPage extends StatefulWidget {
  const ManageAdminPage({ Key? key }) : super(key: key);

  @override
  State<ManageAdminPage> createState() => _ManageAdminPageState();
}

class _ManageAdminPageState extends State<ManageAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        title: Text("Manage Admin"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> AddAdminPage()
                  )
                );
              },
              child: manageUser("Add Admin", Color(0xFFFEB2ED))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> UpdateAdminPage()
                  )
                );
              },
              child: manageUser("Update Admin", Color(0xFFADFFAB))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> DeleteAdminPage()
                  )
                );
              },
              child: manageUser("Delete Admin", Color(0xFFFFD1A7))
            ),
          ]
        ),
      ),
    );
  }

  Widget manageUser(String text, Color color){
    return Container(
      width: 270,
      height: 70,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "QuickSand",
            fontSize: 21
          )
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}