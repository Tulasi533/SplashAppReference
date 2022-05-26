import 'package:flutter/material.dart';
import 'package:splash_app/FacultyFlow/FacultyAddWinnersPage.dart';
import 'package:splash_app/FacultyFlow/FacultyTrackRegistrationsPage.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/Model/superModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class FacultyEvent extends StatefulWidget {
  final String heading;
  final String url;
  final List<String> list;
  const FacultyEvent({ Key? key, required this.heading, required this.url, required this.list}) : super(key: key);

  @override
  State<FacultyEvent> createState() => _FacultyEventState();
}

class _FacultyEventState extends State<FacultyEvent> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<EventModel>? data = [];
  String? type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
      type = superModel.type;
      print(type);
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
            widget.heading,
            style: TextStyle(
              color: Color(0xFFBBFBBA),
              fontSize: 30,
              fontFamily: "QuickSand",
              fontWeight: FontWeight.bold
            ),
          )
        ),
        data!.length > 0 ? Container(
          height: 200,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16, top: 16, bottom: 16),
            itemBuilder: (context, index) => buildCard(data![index]), 
            separatorBuilder: (context, _) => SizedBox(width: 12), 
            itemCount: data!.length,
            scrollDirection: Axis.horizontal
          ),
        ):Center(child: Text("No Events Available",style:TextStyle(color: Colors.white)))
      ],
    );
  }

  Widget buildCard(EventModel item) {
    return Row(
      children: [
        Container(
          width: 140,
          child: Column(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: networkHandler.getImage(item.id.toString()),
                ),
              ),
              //SizedBox(height: 4),
              Text(
                item.name.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFAFCA8),
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.heading == "Upcoming Events") ...[
              InkWell(
                onTap: (){

                },
                child: Text(
                  "Update Event Details",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Manage Coordinators",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Track Registrations",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Delete Event",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
            ] 
            else if(widget.heading == "Ongoing Events")...[
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Manage Coordinators",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> FacultyAddWinnersPage(item: item)
                    )
                  );
                },
                child: Text(
                  "Add Winners",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Add Certificates",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
            ]
            else ...[
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Manage Coordinators",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> FacultyTrackRegistrationsPage(item: item)
                    )
                  );
                },
                child: Text(
                  "Track Registrations",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> FacultyAddWinnersPage(item: item)
                    )
                  );
                },
                child: Text(
                  "Add Winners",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Add Certificates",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Text(
                  "Delete Event",
                  style: TextStyle(
                    color: Color(0xFFfabbf4),
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ),
            ]
          ],
          // children: widget.list.map((option) => new Text(
          //   option,
          //   style: TextStyle(
          //     color: Color(0xFFfabbf4),
          //     fontFamily: "QuickSand",
          //     fontWeight: FontWeight.bold,
          //     fontSize: 15
          //   ),
          // )).toList()
        )

      ]
    );
  }
}