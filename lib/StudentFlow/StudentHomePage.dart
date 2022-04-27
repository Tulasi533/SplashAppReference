import 'package:flutter/material.dart';
import 'package:splash_app/Event/Events.dart';
import 'package:splash_app/StudentFlow/StudentMenuPage.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({ Key? key }) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=> StudentMenuPage()
              )
            );
          } 
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Events(url: "/event/getUpcomingEvents", heading: "Upcoming Events"),
            Divider(thickness: 1.5, color: Colors.white),
            Events(url: "/event/getOngoingEvents", heading: "Ongoing Events"),
            Divider(thickness: 1.5, color: Colors.white),
            Events(url: "/event/getPastEvents", heading: "Past Events")
          ]
        ),
      )
    );
  }
}