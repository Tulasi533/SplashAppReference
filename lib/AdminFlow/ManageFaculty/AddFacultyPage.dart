import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:splash_app/NetworkHandler.dart';

class AddFacultyPage extends StatefulWidget {
  const AddFacultyPage({ Key? key }) : super(key: key);

  @override
  State<AddFacultyPage> createState() => _AddFacultyPageState();
}

class _AddFacultyPageState extends State<AddFacultyPage> {
  final NetworkHandler networkHandler = NetworkHandler();
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        title: Text("Add Faculty"),
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
            Text(
              "Add Multipe faculty??",
              style: TextStyle(
                color: Color(0xFFB2FFFF),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async{
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx'],);

                if (result != null) {
                  var response = await networkHandler.postFile("/faculty/uploadFile", file!.path.toString());
                  if(response.statusCode == 200 || response.statusCode == 201){
                    final snackBar = SnackBar(
                      content: const Text("Faculty Data added Successfully"),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else{
                    final snackBar = SnackBar(
                      content: const Text("Something went wrong!!"),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  setState((){
                    file = result.files.single;
                    
                  });
                  print(file!.name);
                } else {
                  return;
                }
              },
              child: Container(
                width: 250,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.upload,
                      size: 24,
                      color: Color(0xFFFE9EEF)
                    ),
                    Text(
                      "Upload Excel Sheet",
                      style: TextStyle(
                        color: Color(0xFFFE9EEF),
                        fontFamily: "QuickSand",
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            Text(
              file != null ? file!.name.toString() : "",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Text(
              "Only .xlsx file allowed",
              style: TextStyle(
                color: Colors.yellow[200],
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Add Single faculty??",
              style: TextStyle(
                color: Color(0xFFB2FFFF),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                
              },
              child: Container(
                width: 250,
                height: 70,
                child: Center(
                  child: Text(
                    "Add Details",
                    style: TextStyle(
                      color: Color(0xFFFE9EEF),
                      fontFamily: "QuickSand",
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
            )
          ],
        )
      )
    );
  }
}