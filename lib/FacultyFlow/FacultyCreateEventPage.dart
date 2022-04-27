import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splash_app/CustomWidgets/OverlayCard.dart';
import 'package:splash_app/FacultyFlow/FacultyHomePage.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:splash_app/NetworkHandler.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class FacultyEventCreatePage extends StatefulWidget {
  const FacultyEventCreatePage({ Key? key }) : super(key: key);

  @override
  State<FacultyEventCreatePage> createState() => _FacultyEventCreatePageState();
}

class _FacultyEventCreatePageState extends State<FacultyEventCreatePage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _eligibility = TextEditingController();
  TextEditingController _regstartdate = TextEditingController();
  TextEditingController _regenddate = TextEditingController();
  TextEditingController _eventstartdate = TextEditingController();
  TextEditingController _eventenddate = TextEditingController();
  TextEditingController _venue = TextEditingController();
  TextEditingController _scope = TextEditingController();
  TextEditingController _discription = TextEditingController();
  TextEditingController _winnercriteria = TextEditingController();
  TextEditingController _organizer = TextEditingController();

  final _globalkey = GlobalKey<FormState>();
  ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    //final format = DateFormat('d-MMM-YYYY, HH:mm');
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
      body:Form(
        key: _globalkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child:ListView(
            children: [
              InkWell(
                onTap: () {
                  takeCoverPhoto();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    uploadImageField(),
                    Builder(
                      builder: (context) =>FlatButton(
                        onPressed: () {
                          // _globalkey.currentState!.validate()
                          if(_imageFile != null){
                            showModalBottomSheet(
                              context: context, 
                              builder: (builder) => OverlayCard(
                                imageFile: _imageFile
                              )
                            );
                          }
                          else{
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFFF47887),
                                content: Text(
                                  "Please upload Event Poster",
                                  style: TextStyle(
                                    fontFamily: "QuickSand",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  )
                                )
                              )
                            );
                          }
                        }, 
                        child: Text(
                          "Preview",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        )
                      )
                    )
                  ],
                )
              ),
              SizedBox(height: 25),
              nameTextField(),
              SizedBox(height: 25),
              organizerTextField(),
              SizedBox(height: 25),
              scopeTextField(),
              SizedBox(height: 25),
              eligibilityTextField(),
              SizedBox(height: 25),
              regstartdateTextField(),
              SizedBox(height: 25),
              regenddateTextField(),
              SizedBox(height: 25),
              venueTextField(),
              SizedBox(height: 25),
              eventstartdateTextField(),
              SizedBox(height: 25),
              eventenddateTextField(),
              SizedBox(height: 25),
              discriptionTextField(),
              SizedBox(height: 25),
              winnercriteriaTextField(),
              SizedBox(height: 25),
              addButton()
            ]
          )
        ),
      )
    );
  }
  Widget uploadImageField() {
    return Align(
      child:Container(
        width: 230,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF3BAE7),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconphoto,
              size: 30,
            ),
            SizedBox(width: 13),
            Text(
              "Upload Event Poster",
              style: TextStyle(
                fontFamily: "QuickSand",
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      )
    );
  }

  Widget nameTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _name,
          validator: (value) {
            if(value!.isEmpty) {
              return "Event Name can't be empty";
            }
            else if(value.length > 100){
              return "Event Name length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Event Name",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter your Event Name",
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
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget organizerTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _organizer,
          validator: (value) {
            if(value!.isEmpty) {
              return "Organizer can't be empty";
            }
            else if(value.length > 100){
              return "Organizer length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Organizer",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Enter Organizer Name",
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
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget scopeTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _scope,
          validator: (value) {
            if(value!.isEmpty) {
              return "Scope can't be empty";
            }
            else if(value.length > 100){
              return "Scope length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Scope",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Example: Only VIT and SVECW Students",
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
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget eligibilityTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _eligibility,
          validator: (value) {
            if(value!.isEmpty) {
              return "Eligibility can't be empty";
            }
            else if(value.length > 100){
              return "Eligibility length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Eligibility",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Example: Only Girls students of any branch",
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
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget regstartdateTextField() {
    return Column(
      children: [
        DateTimeField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          validator: (value) {
            if(value == null) {
              return "Registration Start Date can't be empty";
            }
            return null;
          },
          controller: _regstartdate,
          format: DateFormat('d-MMM-yyyy, HH:mm'), 
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context, 
              initialDate: currentValue ?? DateTime.now(), 
              firstDate: DateTime.now(), 
              lastDate: DateTime(2100)
            );
            if(date != null){
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
              );
              return DateTimeField.combine(date, time);
            }
            else {
              return currentValue;
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            labelText: "Registration Start DateTime",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Provide Registration Start Date & Time",
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
        )
      ],
    );
  }

  Widget regenddateTextField() {
    return Column(
      children: [
        DateTimeField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          validator: (value) {
            if(value == null) {
              return "Registration End Date can't be empty";
            }
            return null;
          },
          controller: _regenddate,
          
          format: DateFormat('d-MMM-yyyy, HH:mm'), 
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context, 
              initialDate: currentValue ?? DateTime.now(), 
              firstDate: DateTime.now(), 
              lastDate: DateTime(2100)
            );
            if(date != null){
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
              );
              return DateTimeField.combine(date, time);
            }
            else {
              return currentValue;
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            labelText: "Registration End DateTime",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Provide Registration End Date & Time",
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
        )
      ],
    );
  }

  Widget eventstartdateTextField() {
    return Column(
      children: [
        DateTimeField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          validator: (value) {
            if(value == null) {
              return "Event Start Date can't be empty";
            }
            return null;
          },
          controller: _eventstartdate,
          format: DateFormat('d-MMM-yyyy, HH:mm'), 
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context, 
              initialDate: currentValue ?? DateTime.now(), 
              firstDate: DateTime.now(), 
              lastDate: DateTime(2100)
            );
            if(date != null){
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
              );
              return DateTimeField.combine(date, time);
            }
            else {
              return currentValue;
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            labelText: "Event Start DateTime",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Provide Event Start Date & Time",
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
        )
      ],
    );
  }

  Widget eventenddateTextField() {
    return Column(
      children: [
        DateTimeField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          validator: (value) {
            if(value == null) {
              return "Event End Date can't be empty";
            }
            return null;
          },
          controller: _eventenddate,
          format: DateFormat('d-MMM-yyy, HH:mm'), 
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context, 
              initialDate: currentValue ?? DateTime.now(), 
              firstDate: DateTime.now(), 
              lastDate: DateTime(2100)
            );
            if(date != null){
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
              );
              return DateTimeField.combine(date, time);
            }
            else {
              return currentValue;
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            labelText: "Event End DateTime",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Provide Event End Date & Time",
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
        )
      ],
    );
  }

  Widget venueTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _venue,
          validator: (value) {
            if(value!.isEmpty) {
              return "Venue can't be empty";
            }
            else if(value.length > 100){
              return "Venue length should be <= 100";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Venue",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Example: Acadamic Excellence 1st Floor",
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
          maxLength: 100,
          maxLines: null,
        )
      ],
    );
  }

  Widget discriptionTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _discription,
          decoration: InputDecoration(
            labelText: "Discription of Event (Optional)",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "About the Event",
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
          maxLines: 5,
        )
      ],
    );
  }

  Widget winnercriteriaTextField(){
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700
          ),
          controller: _winnercriteria,
          decoration: InputDecoration(
            labelText: "Winner Criteria (Optional)",
            labelStyle: TextStyle(
              color: Color(0xFFe4e6eb)
            ),
            helperText: "Winning Criteria",
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
        )
      ],
    );
  }



  Widget addButton() {
    return Builder(builder: (context) => InkWell(
      onTap: () async{
        if(_imageFile != null && _globalkey.currentState!.validate()){
          EventModel eventModel = EventModel(
            name: _name.text, 
            venue: _venue.text,
            discription: _discription.text,
            scope: _scope.text,
            winnercriteria: _winnercriteria.text,
            eligibility: _eligibility.text,
            organizer: _organizer.text,
            regstartdate: _regstartdate.text,
            regenddate: _regenddate.text,
            eventstartdate: _eventstartdate.text,
            eventenddate: _eventenddate.text,

          );
          var response = await networkHandler.post1("/event/addEvent", eventModel.ToJson());
          print(response.body);

          if(response.statusCode == 200 || response.statusCode == 201) {
            String id = json.decode(response.body)["data"];
            var imageResponse = await networkHandler.patchImage(
              "/event/add/coverImage/$id", _imageFile!.path);
            print(imageResponse.statusCode);
            if(imageResponse.statusCode == 200 || imageResponse.statusCode == 201){
              Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Event added successfully")));
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => FacultyHomePage()), 
                (route) => false
              );
            }
            
          }
          else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Color(0xFFF47887),
                content: Text(
                  "Something Went Wrong",
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  )
                )
              )
            );
          }
        }
        else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xFFF47887),
              content: Text(
                "Please Provide Required Details",
                style: TextStyle(
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                )
              )
            )
          );
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
              "Post New Event",
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
    );
  }
  

  void takeCoverPhoto() async{
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }

}