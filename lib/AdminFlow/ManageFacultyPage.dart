import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/ManageFaculty/AddFacultyPage.dart';
import 'package:splash_app/AdminFlow/ManageFaculty/DeleteFacultyPage.dart';
import 'package:splash_app/AdminFlow/ManageFaculty/UpdateFacultyPage.dart';

class ManageFacultyPage extends StatefulWidget {
  const ManageFacultyPage({ Key? key }) : super(key: key);

  @override
  State<ManageFacultyPage> createState() => _ManageFacultyPageState();
}

class _ManageFacultyPageState extends State<ManageFacultyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        title: Text("Manage Faculty"),
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
                    builder: (context)=> AddFacultyPage()
                  )
                );
              },
              child: manageUser("Add Faculty", Color(0xFFFEB2ED))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> UpdateFacultyPage()
                  )
                );
              },
              child: manageUser("Update Faculty", Color(0xFFADFFAB))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> DeleteFacultyPage()
                  )
                );
              },
              child: manageUser("Delete Faculty", Color(0xFFFFD1A7))
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