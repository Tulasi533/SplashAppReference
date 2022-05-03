import 'package:flutter/material.dart';
import 'package:splash_app/Model/facultyModel.dart';
import 'package:splash_app/Model/studentModel.dart';
import 'package:splash_app/Model/superFacultyModel.dart';
import 'package:splash_app/Model/superStudentModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class FacultyAddStudentPage extends StatefulWidget {
  const FacultyAddStudentPage({ Key? key }) : super(key: key);

  @override
  State<FacultyAddStudentPage> createState() => _FacultyAddStudentPageState();
}

class _FacultyAddStudentPageState extends State<FacultyAddStudentPage> {
  TextEditingController _regnocontroller = TextEditingController();
  StudentModel studentModel = StudentModel();
  SuperStudentModel superStudentModel1 = SuperStudentModel();
  SuperStudentModel superStudentModel2 = SuperStudentModel();
  List<StudentModel>? data = [];
  final NetworkHandler networkHandler = NetworkHandler();
  List<StudentModel>? foundItems = [];
  List<StudentModel>? mystudents = [];

  @override
  void initState() {
    // TODO: implement initState
    foundItems = data;
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response1 = await networkHandler.get("/faculty/getStudents");
    superStudentModel1 = SuperStudentModel.fromJson(response1);
    var response2 = await networkHandler.get("/faculty/getMyStudents");
    superStudentModel2 = SuperStudentModel.fromJson(response2);
    setState(() {
      data = superStudentModel1.data;
      mystudents = superStudentModel2.data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("Manage Your Students"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ),
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                controller: _regnocontroller,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.w700
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    size: 40,
                    color: Color(0xFF09488D)
                  ),
                  hintText: "Search Student by Register Number",
                  hintStyle: TextStyle(
                    color: Color(0xFF6C5555),
                    fontWeight: FontWeight.w700,
                    fontSize: 15
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
                onChanged: (value) => searchFaculty(value),
              ),
            ),
            foundItems!.isNotEmpty? Container(
              decoration: BoxDecoration(
                color: Color(0xFFDDDEFE),
                borderRadius: BorderRadius.circular(30)
              ),
              width: 380,
              child: DataTable(
                dataTextStyle: TextStyle(
                  fontFamily: "QuickSand",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                dataRowHeight: 80,
                columnSpacing: 0,
                headingRowColor:MaterialStateColor.resolveWith((states) => Color(0xFF868a86)),
                dataRowColor:MaterialStateColor.resolveWith((states) => Colors.black),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'RegNo'
                    ),
                  ),
                  DataColumn(label: VerticalDivider(color: Colors.white60, thickness: 1.5)),
                  DataColumn(
                    label: Text(
                      'Name'
                    ),
                  ),
                  DataColumn(label: VerticalDivider(color: Colors.white60, thickness: 1.5)),
                  DataColumn(
                    label: Text(
                      'Action'
                    ),
                  ),
                ],
                rows: List.generate(foundItems!.length, (index) =>
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(foundItems![index].regno.toString())),
                        DataCell(VerticalDivider(color: Colors.white60, thickness: 1.5)),
                        DataCell(Text(foundItems![index].name.toString())),
                        DataCell(VerticalDivider(color: Colors.white60, thickness: 1.5)),
                        foundItems![index].facultyid != "" ? 
                        DataCell(
                          InkWell(
                            onTap:() async{
                              setState(() {
                                _regnocontroller.clear();

                              });
                              var response = await networkHandler.patch("/faculty/removeStudent/${foundItems![index].regno}", {});
                              if(response.statusCode == 200 || response.statusCode == 201) {
                                var response2 = await networkHandler.patch("/faculty/removeFaculty/${foundItems![index].regno}", {});
                              }
                              setState(() {
                                foundItems = [];
                                fetchData();
                              });
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFffbdbf),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Color(0xFFf70c13),
                                )
                              )
                            )
                          )
                        ) : 
                        DataCell(
                          InkWell(
                            onTap:() async{
                              setState(() {
                                _regnocontroller.clear();

                              });
                              var response = await networkHandler.patch("/faculty/addStudent/${foundItems![index].regno}", {});
                              if(response.statusCode == 200 || response.statusCode == 201) {
                                var response2 = await networkHandler.patch("/faculty/addFaculty/${foundItems![index].regno}", {});
                              }
                              setState(() {
                                foundItems = [];
                                fetchData();
                              });

                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFc1f7be),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF186918),
                                )
                              )
                            )
                          )
                        )
                      ],
                    ),
                ),
              )
            )
            : 
            Text(
              "No results found☹",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold
              )
            ), 
            Divider(color: Colors.white60, thickness: 2.0,),
            //
            Text(
              "My Students",
              style: TextStyle(
                color: Color(0xFFf2bde8),
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: "QuickSand"
              )
            ),
            SizedBox(height: 10),
            mystudents!.isNotEmpty? Container(
              decoration: BoxDecoration(
                color: Color(0xFFDDDEFE),
                borderRadius: BorderRadius.circular(30)
              ),
              width: 380,
              child: DataTable(
                dataTextStyle: TextStyle(
                  fontFamily: "QuickSand",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                dataRowHeight: 80,
                columnSpacing: 0,
                headingRowColor:MaterialStateColor.resolveWith((states) => Color(0xFF868a86)),
                dataRowColor:MaterialStateColor.resolveWith((states) => Colors.black),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'RegNo'
                    ),
                  ),
                  DataColumn(label: VerticalDivider(color: Colors.white60, thickness: 1.5)),
                  DataColumn(
                    label: Text(
                      'Name'
                    ),
                  ),
                ],
                rows: List.generate(mystudents!.length, (index) =>
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(mystudents![index].regno.toString())),
                        DataCell(VerticalDivider(color: Colors.white60, thickness: 1.5)),
                        DataCell(Text(mystudents![index].name.toString())),
                      ],
                    ),
                ),
              )
            ): Text(
              "No Student",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold
              )
            ), 
          ]
        )
      )
    );
  }
  void searchFaculty(String query) {
    List<StudentModel>? results = [];
    if(query.isEmpty){
      results = [];
    }
    else{
      results = data!
                .where((student) => 
                  student.regno.toString().toLowerCase().contains(query.toLowerCase()))
                .toList();
    }
    setState(() {
      foundItems = results;
    });
  }
}