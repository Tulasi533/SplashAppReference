import 'package:flutter/material.dart';
import 'package:splash_app/FacultyFlow/FacultyHomePage.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/Model/studentModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class FacultyAddWinnersPage extends StatefulWidget {
  final EventModel item;
  const FacultyAddWinnersPage({ Key? key, required this.item}) : super(key: key);

  @override
  State<FacultyAddWinnersPage> createState() => _FacultyAddWinnersPageState();
}

class _FacultyAddWinnersPageState extends State<FacultyAddWinnersPage> {
  TextEditingController _regnocontroller = TextEditingController();
  TextEditingController _place = TextEditingController();
  List<String>? foundItems = [];
  NetworkHandler networkHandler = NetworkHandler();
  final _globalkey = GlobalKey<FormState>();
  String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Winners"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
          Expanded(
            child: foundItems!.isNotEmpty ? ListView.builder(
              itemCount: foundItems!.length,
              itemBuilder: (context,index) {
                final d = foundItems![index];

                return Padding(
                  padding: EdgeInsets.all(10),
                  child:ListTile(
                    onTap: () {
                      setState(() {
                        text = d;
                        foundItems = [];
                      });
                    },
                    tileColor: Colors.white,
                    leading: Image.network(
                      "https://image.shutterstock.com/image-vector/events-colorful-typography-banner-260nw-1356206768.jpg",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50
                    ) 
                    ,
                    title: Text(
                      d,
                      style: TextStyle(
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                  )
                );
              }
            ): Column(
              children: [
                Text(
                  text == null ? "No results found☹": text.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  key: _globalkey,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.w700
                          ),
                          controller: _place,
                          validator: (value) {
                            if(value!.isEmpty) {
                              return "Venue can't be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Position",
                            labelStyle: TextStyle(
                              color: Color(0xFFe4e6eb)
                            ),
                            helperText: "Runner, Winner, 1st Prize, etc.,",
                            helperStyle: TextStyle(
                              color: Color(0xFFFFCFD8)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                              )
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                            ),
                          ),
                          maxLines: null,
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () async{
                            if(text != null && _globalkey.currentState!.validate()) {
                              Map<String, dynamic> data = {
                                "userid": text.toString(),
                                "place": _place.text,
                                "eventid": widget.item.id
                              };
                              var response = await networkHandler.post1("/winner/addWinner", data);
                              if(response.statusCode == 200 || response.statusCode == 201) {
                                final snackBar = SnackBar(
                                  content: const Text("Winner Added Successfully!!"),
                                  backgroundColor: Colors.green,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                Navigator.pushAndRemoveUntil(
                                  context, 
                                  MaterialPageRoute(builder: (context) => FacultyHomePage()), 
                                  (route) => false
                                );
                              }
                              else {
                                final snackBar = SnackBar(
                                  content: const Text("Something went wrong, Try again!!"),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xFFCEFBCD)
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "QuickSand",
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                            )
                          )
                        )
                      ]
                    )
                  ),
                ) 
              ]
            )
          ),
        ]
      )
    );
  }
  void searchFaculty(String query) {
    List<String>? results = [];
    if(query.isEmpty){
      results = [];
    }
    else{
      results = widget.item.participants!
                .where((user) => 
                  user.toString().toLowerCase().contains(query.toLowerCase()))
                .toList();
    }
    setState(() {
      foundItems = results;
    });
  }
}