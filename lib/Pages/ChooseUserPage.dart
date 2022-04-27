import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminLoginPage.dart';
import 'package:splash_app/FacultyFlow/FacultyLoginPage.dart';
import 'package:splash_app/StudentFlow/StudentLoginPage.dart';

class ChooseUserPage extends StatefulWidget {
  const ChooseUserPage({ Key? key }) : super(key: key);

  @override
  State<ChooseUserPage> createState() => _ChooseUserPageState();
}

class _ChooseUserPageState extends State<ChooseUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login as...🤔🤔",
              style: TextStyle(
                fontSize: 35,
                fontFamily: "MarckScript",
                color: Color(0xFFBAC3F0)
              ),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => AdminLoginPage()
                  )
                );
              },
              child: Container(
                height: 70,
                width: 250,
                child: Center(
                  child: Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFEE5BE),
                  borderRadius: BorderRadius.circular(50)
                ),
              )
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => FacultyLoginPage()
                  )
                );
              },
              child:Container(
                height: 70,
                width: 250,
                child: Center(
                  child: Text(
                    "Faculty",
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE5EA),
                  borderRadius: BorderRadius.circular(50)
                ),
              )
            ),
            
            SizedBox(height: 25),
            InkWell(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => StudentLoginPage()
                  )
                );
              },
              child:Container(
                height: 70,
                width: 250,
                child: Center(
                  child: Text(
                    "Student",
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFC5F4FE),
                  borderRadius: BorderRadius.circular(50)
                ),
              )
            )
          ],
        )
      )
    );
  }
}