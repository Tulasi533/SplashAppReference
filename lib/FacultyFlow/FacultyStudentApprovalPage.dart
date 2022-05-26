import 'package:flutter/material.dart';
import 'package:splash_app/Model/approvalModel.dart';
import 'package:splash_app/Model/superApprovalModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class FacultyStudentApprovalPage extends StatefulWidget {
  const FacultyStudentApprovalPage({ Key? key }) : super(key: key);

  @override
  State<FacultyStudentApprovalPage> createState() => _FacultyStudentApprovalPageState();
}

class _FacultyStudentApprovalPageState extends State<FacultyStudentApprovalPage> {

  TextEditingController _regnocontroller = TextEditingController();
  ApprovalModel approvalModel = ApprovalModel();
  SuperApprovalModel superApprovalModel = SuperApprovalModel();
  List<ApprovalModel>? data = [];
  final NetworkHandler networkHandler = NetworkHandler();
  List<ApprovalModel>? foundItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  void fetchData() async{
    var response = await networkHandler.get("/approval/getUnapprovedData");
    superApprovalModel = SuperApprovalModel.fromJson(response);
    setState(() {
      data = superApprovalModel.data;
      foundItems = data;
    });
  }
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
                      'Event Name'
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
                        DataCell(Text(foundItems![index].eventname.toString())),
                        DataCell(VerticalDivider(color: Colors.white60, thickness: 1.5)),
                        DataCell(
                          Row(
                            children: [
                              InkWell(
                                onTap:() async{
                                  setState(() {
                                    _regnocontroller.clear();
                                  });
                                  var response = await networkHandler.patch("/approval/setStatus/${foundItems![index].id}/True", {});
                                  if(response.statusCode == 200 || response.statusCode == 201) {
                                    var response1 = await networkHandler.patch("/event/addParticipant/${foundItems![index].eventid}/${foundItems![index].regno}", {});
                                    if(response1.statusCode == 200 || response1.statusCode == 201) {
                                      setState(() {
                                        foundItems = [];
                                        fetchData();
                                      });
                                    }
                                  }
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
                                      Icons.check,
                                      color: Color(0xFF186918),
                                    )
                                  )
                                )
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap:() async{
                                  setState(() {
                                    _regnocontroller.clear();
                                  });
                                  var response = await networkHandler.patch("/approval/setStatus/${foundItems![index].id}/False", {});
                                  if(response.statusCode == 200 || response.statusCode == 201) {
                                    setState(() {
                                      foundItems = [];
                                      fetchData();
                                    });
                                  }
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
                                      Icons.cancel,
                                      color: Color(0xFFf70c13),
                                    )
                                  )
                                )
                              )
                            ]
                          )
                          // InkWell(
                          //   onTap:() async{
                          //     setState(() {
                          //       _regnocontroller.clear();

                          //     });
                          //     var response = await networkHandler.patch("/faculty/removeStudent/${foundItems![index].regno}", {});
                          //     if(response.statusCode == 200 || response.statusCode == 201) {
                          //       var response2 = await networkHandler.patch("/faculty/removeFaculty/${foundItems![index].regno}", {});
                          //     }
                          //     setState(() {
                          //       foundItems = [];
                          //       fetchData();
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 45,
                          //     width: 45,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xFFffbdbf),
                          //       borderRadius: BorderRadius.circular(50)
                          //     ),
                          //     child: Center(
                          //       child: Icon(
                          //         Icons.delete,
                          //         color: Color(0xFFf70c13),
                          //       )
                          //     )
                          //   )
                          // )
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
          ]
        )
      )
    );
  }

  void searchFaculty(String query) {
    List<ApprovalModel>? results = [];
    if(query.isEmpty){
      setState(() {
        results = data;
      });
    }
    else{
      results = data!
                .where((approval) => 
                  approval.regno.toString().toLowerCase().contains(query.toLowerCase()))
                .toList();
    }
    setState(() {
      foundItems = results;
    });
  }
}