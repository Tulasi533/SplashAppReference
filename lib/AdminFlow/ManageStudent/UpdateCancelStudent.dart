import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/Model/studentModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class UpdateCancelStudent extends StatefulWidget {
  final String? regNo;
  const UpdateCancelStudent({ Key? key, required this.regNo}) : super(key: key);

  @override
  State<UpdateCancelStudent> createState() => _UpdateCancelStudentState();
}

class _UpdateCancelStudentState extends State<UpdateCancelStudent> {
  final _globalkey = GlobalKey<FormState>();
  final NetworkHandler networkHandler = NetworkHandler();
  StudentModel studentModel = StudentModel();
  final storage = FlutterSecureStorage();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _college = TextEditingController();
  TextEditingController _branch = TextEditingController();
  TextEditingController _facultyid = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    var response = await networkHandler.get("/student/getStudent/${widget.regNo}");
    setState(() {
      studentModel = StudentModel.fromJson(response["data"][0]);
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
      body:Form(
        key: _globalkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child:ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircleAvatar(
                    backgroundImage: NetworkHandler().getImage(studentModel.regno.toString()),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  studentModel.regno.toString(),
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFb8f5bc),
                    fontSize: 20
                  ),
                ),
              ),
              SizedBox(height: 20),
              nameTextField(),
              SizedBox(height: 25),
              mobileTextField(),
              SizedBox(height: 25),
              emailTextField(),
              SizedBox(height: 25),
              branchTextField(),
              SizedBox(height: 25),
              facultyidTextField(),
              SizedBox(height: 25),
              collegeTextField(),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async{
                      if(_globalkey.currentState!.validate()){
                        StudentModel studentModel1 = StudentModel(
                          name: _name.text, 
                          mobile: _mobile.text,
                          email: _email.text,
                          college: _college.text,
                          branch: _branch.text,
                          facultyid: _facultyid.text
                        );
                        var response = await networkHandler.patch("/student/updateStudent/${studentModel.regno}", studentModel1.ToJson());
                        print(response.body);
                        if(response.statusCode == 200 || response.statusCode == 201) {
                          final snackBar = SnackBar(
                            content: const Text("Student Data Updated Successfully"),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context) => AdminHomePage()), 
                            (route) => false
                          );
                        }
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
                          "Update",
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
                  ),
                ]
              )
            ]
          )
        )
      )
    );
  }

  Widget nameTextField(){
    _name.text = studentModel.name.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _name,
          validator: (value) {
            if(value!.isEmpty) {
              return "Student Name can't be empty";
            }
            else if(value.length > 100){
              return "Student Name length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Name",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter your Student Name",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget mobileTextField(){
    _mobile.text = studentModel.mobile.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _mobile,
          validator: (value) {
            if(value!.isEmpty) {
              return "Mobile Number can't be empty";
            }
            else if(value.length > 100){
              return "Mobile Number length should be 10";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Mobile Number",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Mobile Number",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
          maxLength: 10,
          maxLines: null,
        )
      ],
    );
  }

  Widget emailTextField(){
    _email.text = studentModel.email.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _email,
          validator: (value) {
            if(value!.isEmpty) {
              return "Student Email can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Email",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Email",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
        )
      ],
    );
  }

  Widget branchTextField(){
    _branch.text = studentModel.branch.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _branch,
          validator: (value) {
            if(value == null) {
              return "Student Branch can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Branch",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Branch",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
          maxLines: null,
        )
      ],
    );
  }

  Widget facultyidTextField(){
    _facultyid.text = studentModel.facultyid.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _facultyid,
          validator: (value) {
            if(value == null) {
              return "student Mentor can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Mentor ID",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Mentor ID",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
          maxLines: null,
        )
      ],
    );
  }

  Widget collegeTextField(){
    _college.text = studentModel.college.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _college,
          validator: (value) {
            if(value == null) {
              return "Student College can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student College",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student College Name",
            helperStyle: TextStyle(
              color: Color(0xFFFFCFD8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
            ),
          ),
          maxLines: null,
        )
      ],
    );
  }
}