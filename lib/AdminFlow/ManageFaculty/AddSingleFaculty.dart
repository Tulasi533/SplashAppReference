import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/NetworkHandler.dart';

class AddSingleFaculty extends StatefulWidget {
  const AddSingleFaculty({ Key? key }) : super(key: key);

  @override
  State<AddSingleFaculty> createState() => _AddSingleFacultyState();
}

class _AddSingleFacultyState extends State<AddSingleFaculty> {
  final _globalkey = GlobalKey<FormState>();
  final NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _name = TextEditingController();
  TextEditingController _preferredname = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _facultyid = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _college = TextEditingController();
  TextEditingController _department = TextEditingController();
  TextEditingController _position = TextEditingController();
  TextEditingController _qualification = TextEditingController();
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
                  "Add Faculty Details",
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
              facultyidTextField(),
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
              departmentTextField(),
              SizedBox(height: 25),
              positionTextField(),
              SizedBox(height: 25),
              qualificationTextField(),
              SizedBox(height: 25),
              collegeTextField(),
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
                          "facultyid": _facultyid.text,
                          "name": _name.text,
                          "preferredname": _preferredname.text,
                          "email": _email.text,
                          "password": _password.text,
                          "mobile": _mobile.text,
                          "position": _position.text,
                          "department": _department.text,
                          "qualification": _qualification.text,
                          "college": _college.text
                        };
                        print(data);
                        var responseRegister = await networkHandler.post("/faculty/register", data);

                        if (responseRegister.statusCode == 200 ||
                            responseRegister.statusCode == 201) {
                          final snackBar = SnackBar(
                            content: const Text("Faculty Data Added Successfully"),
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
    if (_facultyid.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "Faculty ID Can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/faculty/checkusername/${_facultyid.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "Faculty ID already taken";
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
              return "Faculty Name can't be empty";
            }
            else if(value.length > 100){
              return "Faculty Name length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Name",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty Name",
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
            helperText: "Enter Faculty Preferred Name",
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
              return "Faculty ID can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            labelText: "Faculty ID",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty ID",
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
              return "Faculty Password can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Password",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty Password",
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
              return "Faculty Email can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Email",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty Email",
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
              return "Faculty College can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty College",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty College Name",
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

  Widget departmentTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _department,
          validator: (value) {
            if(value == null) {
              return "Faculty Department can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Department",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty Department",
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

  Widget positionTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _position,
          validator: (value) {
            if(value == null) {
              return "Faculty Position can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Position",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty position",
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

  Widget qualificationTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _qualification,
          validator: (value) {
            if(value == null) {
              return "Faculty Qualification can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Faculty Qualification",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Faculty Qualification",
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