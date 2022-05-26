import 'package:flutter/material.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class FacultyTrackRegistrationsPage extends StatefulWidget {
  final EventModel item;
  const FacultyTrackRegistrationsPage({ Key? key, required this.item}) : super(key: key);

  @override
  State<FacultyTrackRegistrationsPage> createState() => _FacultyTrackRegistrationsPageState();
}

class _FacultyTrackRegistrationsPageState extends State<FacultyTrackRegistrationsPage> {
  final NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("Track Registrations"),
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
            Padding(
              padding: const EdgeInsets.only(left: 110, right: 110),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  backgroundImage: NetworkHandler().getImage(widget.item.id.toString()),
                ),
              ),
            ),
            Text(
              widget.item.name.toString(),
              style: TextStyle(
                color: Color(0xFFFAFCA8),
                fontFamily: "MarckScript",
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}