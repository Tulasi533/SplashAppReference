import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/Model/studentModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class DeleteCancelStudent extends StatefulWidget {
  final String? regNo;
  const DeleteCancelStudent({ Key? key, required this.regNo}) : super(key: key);

  @override
  State<DeleteCancelStudent> createState() => _DeleteCancelStudentState();
}

class _DeleteCancelStudentState extends State<DeleteCancelStudent> {

  final NetworkHandler networkHandler = NetworkHandler();
  StudentModel studentModel = StudentModel();
  bool circular = true;
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    var response = await networkHandler.get("/student/getStudent/${widget.regNo}");
    setState(() {
      studentModel = StudentModel.fromJson(response["data"][0]);
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
            Center(
              child: Text(
                "Student Details",
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
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  backgroundImage: NetworkHandler().getImage(studentModel.regno.toString()),
                ),
              ),
            ),
            SizedBox(height: 30),
            otherDetails("Name", studentModel.name.toString()),
            otherDetails("Email ID", studentModel.email.toString()),
            otherDetails("Mobile Number", studentModel.mobile.toString()),
            otherDetails("College", studentModel.branch.toString()),
            otherDetails("College", studentModel.college.toString()),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async{
                    var response = await networkHandler.delete("/student/delete/${studentModel.regno}");
                    print(response.body);
                    if(response.statusCode == 200){
                      final snackBar = SnackBar(
                        content: const Text("Student Deleted Successfully"),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.popUntil(
                        context, 
                        (route) => route.isFirst
                      );
                      // Navigator.push(
                      //   context, 
                      //   MaterialPageRoute(
                      //     builder: (context) => ManageAdminPage()
                      //   )
                      // );
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
                        "Delete",
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
                )
              ],
            )
            )
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