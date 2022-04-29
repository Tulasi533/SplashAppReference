import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/ManageFaculty/DeleteCancelFaculty.dart';
import 'package:splash_app/Model/facultyModel.dart';
import 'package:splash_app/Model/superFacultyModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class DeleteFacultyPage extends StatefulWidget {
  const DeleteFacultyPage({ Key? key }) : super(key: key);

  @override
  State<DeleteFacultyPage> createState() => _DeleteFacultyPageState();
}

class _DeleteFacultyPageState extends State<DeleteFacultyPage> {

  TextEditingController _adminidcontroller = TextEditingController();
  FacultyModel facultyModel = FacultyModel();
  SuperFacultyModel superFacultyModel = SuperFacultyModel();
  List<FacultyModel>? data = [];
  final NetworkHandler networkHandler = NetworkHandler();
  List<FacultyModel>? foundItems = [];

  @override
  void initState() {
    // TODO: implement initState
    foundItems = data;
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response = await networkHandler.get("/faculty/getAllData");
    superFacultyModel = SuperFacultyModel.fromJson(response);
    setState(() {
      data = superFacultyModel.data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("Search Faculty to Delete"),
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
              controller: _adminidcontroller,
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
                hintText: "Search Faculty By Faculty ID",
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
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => DeleteCancelFaculty(facultyId: d.facultyid)
                        )
                      );
                    },
                    tileColor: Colors.white,
                    leading: (d.img.toString()).contains(d.facultyid.toString()) ? Image.network(
                      "http://192.168.0.103:5000/uploads/${d.facultyid}.jpg",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50
                    ) : Image.network(
                      d.img.toString(),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50
                    ) 
                    ,
                    title: Text(
                      d.facultyid.toString() + ", " + d.name.toString(),
                      style: TextStyle(
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                  )
                );
              }
            ): Text(
              "No results found☹",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold
              )
            )
          )
        ],
      )
    );
  }

  void searchFaculty(String query) {
    List<FacultyModel>? results = [];
    if(query.isEmpty){
      results = [];
    }
    else{
      results = data!
                .where((faculty) => 
                  faculty.facultyid.toString().toLowerCase().contains(query.toLowerCase()))
                .toList();
    }
    setState(() {
      foundItems = results;
    });
  }
}