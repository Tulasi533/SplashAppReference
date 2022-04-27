import 'package:flutter/material.dart';
import 'package:splash_app/Event/AboutEvent.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/Model/superModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class Events extends StatefulWidget {
  final String heading;
  final String url;
  const Events({ Key? key, required this.heading, required this.url}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

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
        ):Center(child: Text("No Blogs Available",style:TextStyle(color: Colors.white)))
      ],
    );
  }

  Widget buildCard(EventModel item) {
    return Container(
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
          InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> AboutEvent(item: item, type: type.toString())
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