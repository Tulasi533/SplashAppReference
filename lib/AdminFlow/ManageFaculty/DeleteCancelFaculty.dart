import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/Model/facultyModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class DeleteCancelFaculty extends StatefulWidget {
  final String? facultyId;
  const DeleteCancelFaculty({ Key? key, required this.facultyId}) : super(key: key);

  @override
  State<DeleteCancelFaculty> createState() => _DeleteCancelFacultyState();
}

class _DeleteCancelFacultyState extends State<DeleteCancelFaculty> {

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
    var response = await networkHandler.get("/faculty/getFaculty/${widget.facultyId}");
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
            Center(
              child: Text(
                "Faculty Details",
                style: TextStyle(
                  color: Color(0xFFBAC3F0),
                  fontFamily: "MarckScript",
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Image.network(
            //   "http://192.168.0.103:5000/uploads/${facultyModel.facultyid.toString()}.jpg",
            //   width: 200,
            //   height: 200,
            //   fit: BoxFit.cover,
              
            // ),
            // CircleAvatar(
            //   radius: 80,
            //   backgroundImage: NetworkHandler().getImage(facultyModel.facultyid.toString()),
            //   backgroundColor: Colors.transparent
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  backgroundImage: NetworkHandler().getImage(facultyModel.facultyid.toString()),
                ),
              ),
            ),
            SizedBox(height: 30),
            otherDetails("Name", facultyModel.name.toString()),
            otherDetails("Email ID", facultyModel.email.toString()),
            otherDetails("Mobile Number", facultyModel.mobile.toString()),
            otherDetails("Position", facultyModel.position.toString()),
            otherDetails("Department", facultyModel.department.toString()),
            otherDetails("College", facultyModel.college.toString()),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async{
                    var response = await networkHandler.delete("/faculty/delete/${facultyModel.facultyid}");
                    print(response.body);
                    if(response.statusCode == 200){
                      final snackBar = SnackBar(
                        content: const Text("Faculty Deleted Successfully"),
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