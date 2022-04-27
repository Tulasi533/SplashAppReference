import 'package:flutter/material.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class AboutEvent extends StatefulWidget {
  final EventModel item;
  final String type;
  const AboutEvent({ Key? key, required this.item, required this.type}) : super(key: key);

  @override
  State<AboutEvent> createState() => _AboutEventState();
}

class _AboutEventState extends State<AboutEvent> {
  NetworkHandler networkHandler = NetworkHandler();
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
        child: Center(
          child:Column(
            children: [
              SizedBox(height: 10),
              CircleAvatar(
                radius: 85,
                backgroundImage: networkHandler.getImage(widget.item.id.toString()),
              ),
              SizedBox(height: 10),
              Text(
                widget.item.name.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "QuickSand",
                  color: Color(0xFFFAFCA8),
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 15),
              // otherDetails("Organizer", widget.item.organizer.toString().toUpperCase()),
              // otherDetails("Scope", widget.item.scope.toString().toUpperCase()),
              // otherDetails("Eligibilty", widget.item.eligibility.toString().toUpperCase()),
              // otherDetails("Registation Start Date", widget.item.regstartdate.toString().toUpperCase()),
              // otherDetails("Registration End Date", widget.item.regenddate.toString().toUpperCase()),
              // otherDetails("Venue", widget.item.venue.toString().toUpperCase()),
              // otherDetails("Event Start Date", widget.item.eventstartdate.toString().toUpperCase()),
              // otherDetails("Event End Date", widget.item.eventenddate.toString().toUpperCase()),
              // if(widget.item.discription.toString() != "") otherDetails("About Event", widget.item.discription.toString().toUpperCase()),
              // if(widget.item.winnercriteria.toString() != "") otherDetails("Winner Criteria", widget.item.winnercriteria.toString().toUpperCase()),
              // SizedBox(height: 30),
              
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDDDEFE),
                  borderRadius: BorderRadius.circular(30)
                ),
                width: 380,
                child:DataTable(
                  dataTextStyle: TextStyle(
                    fontFamily: "QuickSand",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  dataRowHeight: 80,
                  columnSpacing: 0,
                  headingRowHeight: 0,
                  headingRowColor:MaterialStateColor.resolveWith((states) => Color(0xFFDDDEFE)),
                  dataRowColor:MaterialStateColor.resolveWith((states) => Color(0xFFDDDEFE)),
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Event Name'
                      ),
                    ),
                    DataColumn(label: Text("")),
                    DataColumn(
                      label: Text(
                        widget.item.name.toString()
                      ),
                    )
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Organizer")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.organizer.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Scope")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.scope.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Eligibility")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.eligibility.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Registration Start Date")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.regstartdate.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Registration End Date")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.regenddate.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Venue")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.venue.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Event Start Date")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.eventstartdate.toString()))
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Event End Date")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(Text(widget.item.eventenddate.toString()))
                      ],
                    ),
                    if(widget.item.discription.toString() != "")
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("About Event")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(
                          Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              child:Text(widget.item.discription.toString())
                            )
                          )
                        )
                      ],
                    ),
                    if(widget.item.winnercriteria.toString() != "")
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("About Event")),
                        DataCell(VerticalDivider(color: Colors.black26, thickness: 1.5)),
                        DataCell(
                          Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              child:Text(widget.item.winnercriteria.toString())
                            )
                          )
                        )
                      ],
                    ),
                  ], 
                ) 
              ),
              SizedBox(height: 30),
              if(widget.type.toString() == "upcoming") 
              InkWell(
                onTap: (){
                  
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFBC8D1)
                  ),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  )
                ),
              ),
              if(widget.type.toString() == "past") 
              InkWell(
                onTap: (){
                  
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFBA2F7)
                  ),
                  child: Center(
                    child: Text(
                      "View Winners",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  )
                ),
              ),
            ]
          ),
        ) 
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label :",
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD1F7FF),
              fontFamily: "QuickSand"
            ),
          ),
          SizedBox(width: 5),
          Expanded(child: Text(
            value,
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFFFFE0E6),
              fontFamily: "QuickSand",
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible
            ),
          )
          )
        ],
      )
    );
  }
}