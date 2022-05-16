import 'package:flutter/material.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/Model/facultyModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class AboutFacultyWinner extends StatefulWidget {
  final FacultyModel facultyModel;
  final String eventid;
  final String place;
  const AboutFacultyWinner({ Key? key, required this.facultyModel, required this.eventid, required this.place}) : super(key: key);

  @override
  State<AboutFacultyWinner> createState() => _AboutFacultyWinnerState();
}

class _AboutFacultyWinnerState extends State<AboutFacultyWinner> {
  NetworkHandler networkHandler = NetworkHandler();
  EventModel eventModel = new EventModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    var response = await networkHandler.get("/event/getEvent/${widget.eventid}");
    setState(() {
      eventModel = EventModel.fromJson(response["data"][0]);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
              "🥳 Congratulations 🥳",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "MarckScript",
                fontWeight: FontWeight.bold,
                fontSize: 35
              )
            ),
            SizedBox(height: 10),
            Padding(
              padding:EdgeInsets.only(left: 130, right: 130), 
              child: AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  backgroundImage: (widget.facultyModel.img.toString()).contains(widget.facultyModel.facultyid.toString())? NetworkHandler().getImage(widget.facultyModel.facultyid.toString()): NetworkImage(widget.facultyModel.img.toString()),
                ),
              ),
            ),
            SizedBox(height:8),
            Text(
              widget.facultyModel.name.toString(),
              style: TextStyle(
                color: Color(0xFFFAFCA8),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 20
              )
            ),
            SizedBox(height:3),
            Text(
              widget.facultyModel.facultyid.toString(),
              style: TextStyle(
                color: Color(0xFFF1BAFA),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 17
              )
            ),
            SizedBox(height:3),
            Text(
              widget.facultyModel.position.toString(),
              style: TextStyle(
                color: Color(0xFFF7FCBA),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            SizedBox(height:3),
            Text(
              widget.facultyModel.department.toString(),
              style: TextStyle(
                color: Color(0xFFBAD4FA),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            SizedBox(height:3),
            Text(
              widget.facultyModel.college.toString(),
              style: TextStyle(
                color: Color(0xFFB8F4B6),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            SizedBox(height: 10),
            Divider(color: Colors.white, thickness: 2.0,),
            SizedBox(height:10),
            Text(
              widget.place,
              style: TextStyle(
                color: Color(0xFFFCA8B2),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 26,
                decoration: TextDecoration.underline,
                
              )
            ),
            SizedBox(height: 4),
            Text(
              eventModel.name.toString(),
              style: TextStyle(
                color: Color(0xFFFBFBFD),
                fontFamily: "MarckScript",
                fontWeight: FontWeight.bold,
                fontSize: 35
              )
            ),
            Text(
              "conducted by",
              style: TextStyle(
                color: Color(0xFFB3F6A8),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 20,  
              )
            ),
            SizedBox(height: 5),
            Text(
              eventModel.organizer.toString(),
              style: TextStyle(
                color: Color(0xFFDFC8F0),
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold,
                fontSize: 25,  
              )
            ),
          ]
        )
      )
    );
  }
}