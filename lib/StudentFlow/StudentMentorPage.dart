import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/Model/facultyModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class StudentMentorPage extends StatefulWidget {
  final String? facultyId;
  const StudentMentorPage({ Key? key, this.facultyId}) : super(key: key);

  @override
  State<StudentMentorPage> createState() => _StudentMentorPageState();
}

class _StudentMentorPageState extends State<StudentMentorPage> {
  final NetworkHandler networkHandler = NetworkHandler();
  FacultyModel facultyModel = FacultyModel();
  bool circular = true;
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    var response = await networkHandler.get("/student/getMentor/${widget.facultyId}");
    setState(() {
      facultyModel = FacultyModel.fromJson(response["data"][0]);
      circular = false;
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
      body: circular 
      ? CircularProgressIndicator() 
      : Center(
        child: ListView(
          children: [
            SizedBox(height: 40),
            Center(
              child: Text(
                "Mentor Details🧑‍🏫🧑‍🏫",
                style: TextStyle(
                  color: Color(0xFFBAC3F0),
                  fontFamily: "MarckScript",
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 110, right: 110),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  backgroundImage: (facultyModel.img.toString()).contains(facultyModel.facultyid.toString())? NetworkHandler().getImage(facultyModel.facultyid.toString()): NetworkImage(facultyModel.img.toString()),
                ),
              ),
            ),
            SizedBox(height: 30),
            otherDetails("Name", facultyModel.name.toString()),
            otherDetails("Email ID", facultyModel.email.toString()),
            otherDetails("Mobile Number", facultyModel.mobile.toString()),
            otherDetails("Position", facultyModel.position.toString()),
            otherDetails("Department", facultyModel.department.toString()),
            otherDetails("College", facultyModel.college.toString())
          ],
        )
      )
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label :",
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD1F7FF),
              fontFamily: "QuickSand"
            ),
          ),
          SizedBox(width: 5),
          Expanded(child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFE0E6),
              fontFamily: "QuickSand",
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible
            ),
          )
          )
        ],
      )
    );
  }

}