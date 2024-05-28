import 'package:flutter/material.dart';
import 'package:news_app/pages/home.dart';
class Landingpage extends StatefulWidget
{
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: Column(
          children: [
            Material(
              elevation: 6.0,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(

                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/news1.jpg",
                  height:MediaQuery.of(context).size.height/1.7,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text("Stay Informed, Stay Ahead",style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight:FontWeight.bold
              ),),
            ),
            SizedBox(height: 20,),
            Text("Get the latest global headlines, breaking news, and in-depth analysis all in one place. Stay ahead with real-time updates and personalized news coverage tailored just for you. Your gateway to a world of news, anytime, anywhere."),
            SizedBox(height: 20,),
            Material(

              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                    shadowColor: Colors.black54,
                    elevation: 10
                ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const Home()),


                    );
                  }, child: Text("Get Started",style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),)),
            )
          ],
        ),
      ),
    );
  }
}