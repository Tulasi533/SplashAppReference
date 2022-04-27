import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminMenuPage.dart';
import 'package:splash_app/AdminFlow/ManageFacultyPage.dart';
import 'package:splash_app/AdminFlow/ManageStudentPage.dart';
import 'package:splash_app/AdminFlow/ManageadminPage.dart';
import 'package:splash_app/Event/Events.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({ Key? key }) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=> AdminMenuPage()
              )
            );
          } 
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
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
                    builder: (context)=> ManageAdminPage()
                  )
                );
              },
              child: manageUser("Manage Admin", Color(0xFFFEB2ED))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> ManageFacultyPage()
                  )
                );
              },
              child: manageUser("Manage Faculty", Color(0xFFADFFAB))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> ManageStudentPage()
                  )
                );
              },
              child: manageUser("Manage Student", Color(0xFFFFD1A7))
            ),
          ]
        ),
      )
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