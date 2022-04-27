import 'package:flutter/material.dart';
import 'package:splash_app/Pages/ChooseUserPage.dart';
import 'package:splash_app/Pages/SignInPage.dart';
import 'package:splash_app/utils/Dimensions.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    print("Current height is:"+ MediaQuery.of(context).size.height.toString());
    print("Current width is:"+ MediaQuery.of(context).size.width.toString());
    return Scaffold(
      backgroundColor: Color(0xFF09488D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Image.asset("assets/images/happy_news.png"),
          ),
          SizedBox(height: 40),
          Text(
            "Get in touch with Campus Events",
            style: TextStyle(
              color: Color(0xFFBAC3F0),
              fontSize: 27,
              fontFamily: "MarckScript",
              //letterSpacing: 2,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ChooseUserPage()
                )
              );
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFFCCD2F5)
              ),
              child: Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.w800
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}