import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/ManageStudent/AddStudentPage.dart';
import 'package:splash_app/AdminFlow/ManageStudent/DeleteStudentPage.dart';
import 'package:splash_app/AdminFlow/ManageStudent/UpdateStudentPage.dart';

class ManageStudentPage extends StatefulWidget {
  const ManageStudentPage({ Key? key }) : super(key: key);

  @override
  State<ManageStudentPage> createState() => _ManageStudentPageState();
}

class _ManageStudentPageState extends State<ManageStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        title: Text("Manage Student"),
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
                    builder: (context)=> AddStudentPage()
                  )
                );
              },
              child: manageUser("Add Student", Color(0xFFFEB2ED))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> UpdateStudentPage()
                  )
                );
              },
              child: manageUser("Update Student", Color(0xFFADFFAB))
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> DeleteStudentPage()
                  )
                );
              },
              child: manageUser("Delete Student", Color(0xFFFFD1A7))
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