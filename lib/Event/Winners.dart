import 'package:flutter/material.dart';
import 'package:splash_app/Event/AboutFacultyWinner.dart';
import 'package:splash_app/Event/AboutStudentWinner.dart';
import 'package:splash_app/Model/facultyModel.dart';
import 'package:splash_app/Model/studentModel.dart';
import 'package:splash_app/Model/superWinnerModel.dart';
import 'package:splash_app/Model/winnerModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class Winners extends StatefulWidget {
  const Winners({ Key? key }) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {

  NetworkHandler networkHandler = NetworkHandler();
  SuperWinnerModel superWinnerModel = SuperWinnerModel();
  StudentModel studentModel = StudentModel();
  FacultyModel facultyModel = FacultyModel();
  List<WinnerModel>? data = [];
  
  Map<String, List<String>> studentloaded = {};
  Map<String, List<String>> facultyloaded = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response = await networkHandler.get("/winner/getWinners");
    superWinnerModel = SuperWinnerModel.fromJson(response);
    setState(() {
      data = superWinnerModel.data;
    });
  }

  void fetchFacultyData(String id) async{
    var response = await networkHandler.get("/faculty/getFaculty/${id}");
    setState(() {
      facultyModel = FacultyModel.fromJson(response["data"][0]);
    });
  }
 
  void fetchStudentData(String id) async{
    var response = await networkHandler.get("/student/getStudent/${id}");
    setState(() {
      studentModel = StudentModel.fromJson(response["data"][0]);
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
          "Winners",
          style: TextStyle(
            color: Color(0xFFBBFBBA),
            fontSize: 30,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.bold
          ),
        )
        ),
        data!.length > 0 ? Container(
          height: 230,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16, top: 16, bottom: 16),
            itemBuilder: (context, index) => buildCard(data![index]), 
            separatorBuilder: (context, _) => SizedBox(width: 12), 
            itemCount: data!.length,
            scrollDirection: Axis.horizontal
          ),
        ):Center(child: Text("No Winners Available",style:TextStyle(color: Colors.white)))
      ],
    );
  }

  Widget buildCard(WinnerModel item) {
    if(item.userid.toString()[0] == "1"){
      print("iNSIDE sTUDENT");
      print(item.userid.toString()[0]);
      if(studentloaded != null){
        if(studentloaded.containsKey(item.userid.toString())){
          if(studentloaded[item.userid.toString()]!.contains(item.eventid) == false){
            fetchStudentData(item.userid.toString());
            studentloaded[item.userid]!.add(item.eventid.toString());
          }
        }
        else{
          fetchStudentData(item.userid.toString());
          studentloaded.putIfAbsent(item.userid.toString(), () => [item.eventid.toString()]);
        }
      }
      else{
        fetchStudentData(item.userid.toString());
        studentloaded.putIfAbsent(item.userid.toString(), () => [item.eventid.toString()]);
      }
      
      print("student ${studentModel.name}");
      return Container(
        width: 150,
        child: Column(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: networkHandler.getImage(studentModel.regno.toString()),
              ),
            ),
            //SizedBox(height: 4),
            Text(
              studentModel.preferredname.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 17,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAFCA8),
                overflow: TextOverflow.ellipsis
              ),
            ),
            SizedBox(height: 4),
            Text(
              "🎉"+item.place.toString()+"🎉",
              style: TextStyle(
                fontSize: 17,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                overflow: TextOverflow.ellipsis
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> AboutStudentWinner(studentModel: studentModel, eventid: item.eventid.toString(), place: item.place.toString())
                  )
                );
              },
              child: Text(
                "know more",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "QuickSand",
                  color: Color(0xFFFFC6C6),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      );
    }
    else {
      print("iNSIDE faculty");
      print(item.userid.toString()[0]);
      if(facultyloaded != null){
        if(facultyloaded.containsKey(item.userid.toString())){
          if(facultyloaded[item.userid.toString()]!.contains(item.eventid) == false){
            fetchFacultyData(item.userid.toString());
            facultyloaded[item.userid]!.add(item.eventid.toString());
          }
        }
        else{
          fetchFacultyData(item.userid.toString());
          facultyloaded.putIfAbsent(item.userid.toString(), () => [item.eventid.toString()]);
        }
      }
      else{
        fetchFacultyData(item.userid.toString());
        facultyloaded.putIfAbsent(item.userid.toString(), () => [item.eventid.toString()]);
      }
      print("faculty ${facultyModel.name}");
      return Container(
        width: 140,
        child: Column(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: networkHandler.getImage(facultyModel.facultyid.toString()),
              ),
            ),
            //SizedBox(height: 4),
            Text(
              facultyModel.preferredname.toString(),
              style: TextStyle(
                fontSize: 20,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAFCA8),
                overflow: TextOverflow.ellipsis
              ),
            ),
            SizedBox(height: 4),
            Text(
              "🎉"+item.place.toString()+"🎉",
              style: TextStyle(
                fontSize: 17,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                overflow: TextOverflow.ellipsis
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=> AboutFacultyWinner(facultyModel: facultyModel, eventid: item.eventid.toString(), place: item.place.toString())
                  )
                );
              },
              child: Text(
                "know more",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "QuickSand",
                  color: Color(0xFFFFC6C6),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      );
    }
    
  }

  
}