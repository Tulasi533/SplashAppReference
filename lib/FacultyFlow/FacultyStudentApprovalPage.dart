import 'package:flutter/material.dart';

class FacultyStudentApprovalPage extends StatefulWidget {
  const FacultyStudentApprovalPage({ Key? key }) : super(key: key);

  @override
  State<FacultyStudentApprovalPage> createState() => _FacultyStudentApprovalPageState();
}

class _FacultyStudentApprovalPageState extends State<FacultyStudentApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("Student's Approvals"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}