import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/AdminHomePage.dart';
import 'package:splash_app/NetworkHandler.dart';

class AddSingleAdmin extends StatefulWidget {
  const AddSingleAdmin({ Key? key }) : super(key: key);

  @override
  State<AddSingleAdmin> createState() => _AddSingleAdminState();
}

class _AddSingleAdminState extends State<AddSingleAdmin> {
  final _globalkey = GlobalKey<FormState>();
  final NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _adminid = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _college = TextEditingController();
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
      body: Form(
        key: _globalkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child:ListView(
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Add Admin Details",
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
              adminidTextField(),
              SizedBox(height: 25),
              nameTextField(),
              SizedBox(height: 25),
              passwordTextField(),
              SizedBox(height: 25),
              mobileTextField(),
              SizedBox(height: 25),
              emailTextField(),
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
                          "adminid": _adminid.text,
                          "name": _name.text,
                          "email": _email.text,
                          "password": _password.text,
                          "mobile": _mobile.text,
                          "college": _college.text
                        };
                        print(data);
                        var responseRegister = await networkHandler.post("/admin/register", data);

                        if (responseRegister.statusCode == 200 ||
                            responseRegister.statusCode == 201) {
                          final snackBar = SnackBar(
                            content: const Text("Admin Data Added Successfully"),
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
    if (_adminid.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "Admin ID Can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/admin/checkusername/${_adminid.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "Admin ID already taken";
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
              return "Admin Name can't be empty";
            }
            else if(value.length > 100){
              return "Admin Name length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin Name",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter your Admin Name",
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

  Widget adminidTextField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _adminid,
          validator: (value) {
            if(value!.isEmpty) {
              return "Admin ID can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            labelText: "Admin ID",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin ID",
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
            helperText: "Enter your Mobile Number",
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
              return "Admin Email can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin Email",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter your Admin Email",
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
              return "Admin College can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin College",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin College Name",
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
              return "Admin Password can't be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Admin Password",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Admin Password",
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
}