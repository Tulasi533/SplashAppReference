import 'package:flutter/material.dart';
import 'package:splash_app/AdminFlow/ManageAdmin/UpdateCancelAdmin.dart';
import 'package:splash_app/Model/adminModel.dart';
import 'package:splash_app/Model/superAdminModel.dart';
import 'package:splash_app/NetworkHandler.dart';

class UpdateAdminPage extends StatefulWidget {
  const UpdateAdminPage({ Key? key }) : super(key: key);

  @override
  State<UpdateAdminPage> createState() => _UpdateAdminPageState();
}

class _UpdateAdminPageState extends State<UpdateAdminPage> {
  TextEditingController _adminidcontroller = TextEditingController();
  AdminModel adminModel = AdminModel();
  SuperAdminModel superAdminModel = SuperAdminModel();
  List<AdminModel>? data = [];
  final NetworkHandler networkHandler = NetworkHandler();
  List<AdminModel>? foundItems = [];

  @override
  void initState() {
    // TODO: implement initState
    foundItems = data;
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response = await networkHandler.get("/admin/getOtherData");
    superAdminModel = SuperAdminModel.fromJson(response);
    setState(() {
      data = superAdminModel.data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      appBar: AppBar(
        elevation: 0,
        title: Text("Search Admin to Update"),
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
                hintText: "Search Admin By Admin ID",
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
              onChanged: (value) => searchAdmin(value),
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
                          builder: (context) => UpdateCancelAdmin(adminId: d.adminid)
                        )
                      );
                    },
                    tileColor: Colors.white,
                    leading: (d.img.toString()).contains(d.adminid.toString()) ? Image.network(
                      "http://192.168.0.103:5000/uploads/${d.adminid}.jpg",
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
                      d.adminid.toString() + ", " + d.name.toString(),
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

  void searchAdmin(String query) {
    List<AdminModel>? results = [];
    if(query.isEmpty){
      results = [];
    }
    else{
      results = data!
                .where((admin) => 
                  admin.adminid.toString().toLowerCase().contains(query.toLowerCase()))
                .toList();
    }
    setState(() {
      foundItems = results;
    });
  }
}