import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/NetworkHandler.dart';

class AddSingleStudent extends StatefulWidget {
  const AddSingleStudent({ Key? key }) : super(key: key);

  @override
  State<AddSingleStudent> createState() => _AddSingleStudentState();
}

class _AddSingleStudentState extends State<AddSingleStudent> {
  final _globalkey = GlobalKey<FormState>();
  final NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _regno = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _preferredname = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _facultyid = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _college = TextEditingController();
  TextEditingController _branch = TextEditingController();
  TextEditingController _academicstart = TextEditingController();
  TextEditingController _academicend = TextEditingController();
  String? errorText;
  bool validate = false;
  bool circular = false;
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
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Add Student Details",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontFamily: "QuickSand",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  )
                ),
              ),
              SizedBox(height: 25),
              regnoTextField(),
              SizedBox(height: 25),
              nameTextField(),
              SizedBox(height: 25),
              preferrednameTextField(),
              SizedBox(height: 25),
              passwordTextField(),
              SizedBox(height: 25),
              mobileTextField(),
              SizedBox(height: 25),
              emailTextField(),
              SizedBox(height: 25),
              branchTextField(),
              SizedBox(height: 25),
              academicstartTextField(),
              SizedBox(height: 25),
              academicendTextField(),
              SizedBox(height: 25),
              collegeTextField(),
              SizedBox(height: 25),
              facultyidTextField(),
              
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        circular = true;
                      });
                      await checkUser();
                      if (_globalkey.currentState!.validate() && validate) {
                        Map<String, String> data = {
                          "regno": _regno.text,
                          "name": _name.text,
                          "preferredname": _preferredname.text,
                          "email": _email.text,
                          "password": _password.text,
                          "mobile": _mobile.text,
                          "branch": _branch.text,
                          "academicstart": _academicstart.text,
                          "academicend": _academicend.text,
                          "college": _college.text,
                          "facultyid": _facultyid.text
                        };
                        print(data);
                        var responseRegister = await networkHandler.post("/student/register", data);

                        if (responseRegister.statusCode == 200 ||
                            responseRegister.statusCode == 201) {
                          final snackBar = SnackBar(
                            content: const Text("Student Data Added Successfully"),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminHomePage(),
                            ),
                            (route) => false
                          );
                          setState(() {
                            circular = false;
                          });
                        }
                        else {
                          final snackBar = SnackBar(
                            content: const Text("Something went wrong!!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            circular = true;
                          });
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
                        child: circular
                        ? CircularProgressIndicator()
                        : Text(
                          "Add",
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

  checkUser() async {
    if (_regno.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "Register Number Can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/student/checkusername/${_regno.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "Register Number already taken";
        });
      } else {
        setState(() {
          // circular = false;
          validate = true;
        });
      }
    }
  }

  Widget nameTextField(){
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
            helperText: "Enter Student Name",
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

  Widget preferrednameTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _preferredname,
          validator: (value) {
            if(value!.isEmpty) {
              return "Faculty Preferred Name can't be empty";
            }
            else if(value.length > 100){
              return "Faculty Preferred Name length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Preferred Name",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Preferred Name",
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

  Widget facultyidTextField(){
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
            if(value!.isEmpty) {
              return "Mentor ID can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Mentor ID",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Mentor ID",
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
  Widget passwordTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _password,
          validator: (value) {
            if(value!.isEmpty) {
              return "Student Password can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Password",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Password",
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

  Widget mobileTextField(){
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
          maxLength: 10
        )
      ],
    );
  }

  Widget emailTextField(){
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

  Widget collegeTextField(){
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

  Widget branchTextField(){
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
            helperText: "Enter Student Branch Name",
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

  Widget academicstartTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _academicstart,
          validator: (value) {
            if(value == null) {
              return "Student Academic Start Year can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Academic Start Year",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Academic Start Year",
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

  Widget academicendTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _academicend,
          validator: (value) {
            if(value == null) {
              return "Student Academic End Year can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Student Academic End Year",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student Academic End Year",
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

  Widget regnoTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _regno,
          validator: (value) {
            if(value == null) {
              return "Student RegNo can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            labelText: "Student RegNo",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Student RegNo",
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