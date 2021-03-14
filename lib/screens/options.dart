import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map/models/event.dart';
import 'package:map/screens/crimerate.dart';
import 'package:map/utils/filter.dart';
import 'package:map/utils/constant.dart';
import 'package:map/services/auth.dart';
import 'package:map/screens/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:map/services/db.dart';
import 'package:map/screens/safe route.dart';
import 'package:map/screens/chat_bot.dart';
AuthService _auth=AuthService();
class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    DatabaseService _db=DatabaseService();
    return Scaffold(
      body: StreamProvider<events>.value(
        value: _db.streamEvent(),
        child: Container(
            child:Column(
              children: [
                SizedBox(height: 175,),
                box(icon: Icons.insert_chart,tittle: 'Crime Rate',fun: 1,),
                SizedBox(height: 25,),
                box(icon: Icons.location_pin,tittle: 'Safest Route',fun: 2),

                SizedBox(height: 25,),
                box(icon: Icons.chat,tittle: 'Consultation',fun: 3),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(),
                  child: RaisedButton(
                    color: kblue,
                    onPressed:() async{
                      await _auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return onboardingScreen();
                          },
                        ),
                      );


                    },
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}





class box extends StatelessWidget {
  final IconData icon;
  final String tittle;
  final int fun;

  const box({
    Key key, this.icon, this.tittle, this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:25.0,left: 25,right: 25),
      child: GestureDetector(
        onTap:() {
          switch(fun){

            case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) {
            return crimeRate(robbery: 40,murder: 24,other: 60,molestation: 80,drugs: 50,);
          }));
          break;
            case 2: Navigator.push(
                context, MaterialPageRoute(builder: (context) {
              return MapView();
            }));
              break;
            case 3:Navigator.push(
                context, MaterialPageRoute(builder: (context) {
              return ChatBot();
            }));

          }
        },
        child: Container(

          width: double.infinity,
          height: 141,

          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: blackshadow,
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(icon,
                  color: Colors.blue,
                  size: 40,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:95.0,left: 145),
                child: Text(tittle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}