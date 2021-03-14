import 'package:flutter/cupertino.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:map/utils/constant.dart';
import 'package:map/screens/signup.dart';

Color bgColor = Colors.white;
Color textColor = Colors.black;

List<String> title = ["Crime Master GOGO", "GOGO Finder","GOGO Chat"];
List<String> description = [
  "Provide you the safest route to reach your location.",
  "provides the crime statics of any area you want.",
  "chat with our expert gogo in case you are in trouble"
];
List<String> pictures = ["Frame1.png", "Frame2.png","Frame3.png"];


class onboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ContentPage(),
    );
  }
}

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: false,
                initialPage: 0,
                reverse: false,
                viewportFraction: 1.0,
                aspectRatio: MediaQuery.of(context).size.aspectRatio,
                height: MediaQuery.of(context).size.height - 30,
              ),

              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: AppItro(i));
                  },
                );
              }).toList(),
            ),
          ],
        ));
  }
}

class AppItro extends StatefulWidget {
  int index;
  AppItro(this.index);
  @override
  _AppItroState createState() => _AppItroState();
}

class _AppItroState extends State<AppItro> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/" + pictures[widget.index],
                    width: MediaQuery.of(context).size.width / 1.3,
                  )
//                    SvgPicture.asset("assets/logo.svg",
//                      width: MediaQuery.of(context).size.width/4,
//                    ),
              ),
//                  SizedBox(
//                    width: MediaQuery.of(context).size.width/6,
//                  ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 2 - 27),
                height: 50,
                child: Dots(widget.index),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      title[widget.index],
                      textAlign: TextAlign.center,
                      style: TextStyle(

                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      children: [
                        //Text -- Line
                        Center(
                          child: new RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: description[widget.index],
                                    ),
                                  ])),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        //Bottom buttons
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 15,
          child: Stack(
            children: <Widget>[
              //Skip Button
              Positioned(
                  left: 24,
                  bottom: 10,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(builder: (context) => signUpScreen()),
                      );
                    },
                    child: Text(
                      widget.index == 2 ? "" : "SKIP",
                      style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.w500 //

                      ),
                    ),
                  )),
              //Done Button
              Positioned(
                  right: 24,
                  bottom: 15,
                  child: widget.index < 2
                      ? Padding(
                    //no. of screens -1
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Swipe Right -->",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  )
                      : FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => signUpScreen()),
                      );
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
//
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

//Dots
class Dots extends StatefulWidget {
  int index;
  Dots(this.index);
  @override
  _DotsState createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  @override
  void initState() {
    super.initState();
    // print("deneme" + currentPage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, int index) {
        return Container(
          margin: EdgeInsets.only(right: index != 2 ? 3 : 0),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == widget.index ? kblue : kgrey,
          ),
        );
      },
    );
  }
}

