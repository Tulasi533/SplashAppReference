import 'package:flutter/material.dart';
import 'package:splash_app/Event/FacultyEvent.dart';

class FacultyMyEventsPage extends StatefulWidget {
  const FacultyMyEventsPage({ Key? key }) : super(key: key);

  @override
  State<FacultyMyEventsPage> createState() => _FacultyMyEventsPageState();
}

class _FacultyMyEventsPageState extends State<FacultyMyEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("My Events"),
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
            FacultyEvent(url: "/faculty/getMyUpcomingEvents", heading: "Upcoming Events", list: ["Update Event Details", "Manage Coordinators", "Track Registrations", "Delete Event"]),
            Divider(thickness: 1.5, color: Colors.white),
            FacultyEvent(url: "/faculty/getMyOngoingEvents", heading: "Ongoing Events", list: ["Manage Coordinators", "Add Winners", "Add Certificates"]),
            Divider(thickness: 1.5, color: Colors.white),
            FacultyEvent(url: "/faculty/getMyPastEvents", heading: "Past Events", list: ["Manage Coordinators", "Add Winners", "Add Certificates", "Delete Event"])
          ]
        ),
      ),
    );
  }
}