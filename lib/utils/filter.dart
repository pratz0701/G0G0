import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:map/location.dart';
import 'package:map/services/db.dart';
import 'package:map/models/user.dart';
//import 'map';
import 'dart:math';
import 'package:map/screens/crimerate.dart';
import 'package:map/utils/constant.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  Random random = new Random();

  bool disablemonth = true;
  bool disaclecity = true;
  String chooseyear;
  String choosemonth;
  String countryValue;
  String stateValue;
  String cityValue;
  String choosecity;
  String choosestate;
  List<DropdownMenuItem<String>> listmonth = List();
  Map<String, String> stateCity = {
    "Allahabad": "Uttar Pradesh",
    "Agra": "Uttar Pradesh",
    "Mumbai": "Maharashtra",
    "Pune": "Maharashtra",
    "Jaipur": "Rajasthan",
    "Udaipur": "Rajasthan",
    "Patna": "Bihar",
    "Ahmedabad": "Gujarat",
    "Karnataka": "Bangalore",
    "Delhi": "Delhi"
  };

  List<String> state = [
    'Uttar Pradesh',
    'Maharashtra',
    'Rajasthan',
    'Bihar',
    'Gujarat',
    'Bangalore',
    'Delhi'
  ];
  List<String> city = [];

  String selectedState;
  String selectedcity;

  final app = {
    "1": "january",
    "2": "february",
  };

  final web = {
    "1": "January",
    "2": "February",
    "3": "March",
    "4": "April",
    "5": "May",
    "6": "June",
    "7": "July",
    "8": "August",
    "9": "September",
    "10": "October",
    "11": "November",
    "12": "December",
  };
  void populateyear1() {
    for (String key in app.keys) {
      listmonth.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(app[key]),
        ),
        value: app[key],
      ));
    }
  }

  void populateyear2() {
    for (String key in web.keys) {
      listmonth.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(web[key]),
        ),
        value: web[key],
      ));
    }
  }

  void selected(_value) {
    if (_value ==
        "year1"
            "") {
      listmonth = [];
      populateyear2();
    } else if (_value == "year2") {
      listmonth = [];
      populateyear1();
    }
    setState(() {
      chooseyear = _value;
      disablemonth = false;
    });
  }

  void secondselected(_value) {
    setState(() {
      choosemonth = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    DatabaseService _db=DatabaseService();
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Filter',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Text(
            'Choose a date',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
          child: DropdownButton(
            // hint: Text('year'),
            value: chooseyear,
            items: [
              DropdownMenuItem<String>(
                value: "year1",
                child: Center(
                  child: Text("2021"),
                ),
              ),
              DropdownMenuItem<String>(
                value: "year2",
                child: Center(
                  child: Text("2020"),
                ),
              ),
            ].toList(),
            onChanged: (_value) => selected(_value),
            hint: Text("Select a year"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
          child: DropdownButton(
            hint: Text('select a month'),
            value: choosemonth,
            onChanged: disablemonth
                ? null
                : (newValue) {
                    setState(() {
                      choosemonth = newValue;
                    });
                  },
            items: listmonth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
          child: Text(
            'Choose a location',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
          child: DropdownButton(
            hint: Text('select a state'),
            onChanged: (value) {
              setState(() {
                selectedState = value;
                selectedcity = null;
                city.clear();
                stateCity.forEach((k, v) {
                  print(k);
                  if (selectedState == v) {
                    city.add(k);
                  }
                });
              });
            },
            value: selectedState,
            items: state
                .map((state) => DropdownMenuItem(
                      child: Text(state),
                      value: state,
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
          child: DropdownButton(
            hint: Text('select a city'),
            onChanged: (value) {
              setState(() {
                selectedcity = value;
              });
              print(value);
            },
            value: selectedcity,
            items: selectedState != null
                ? city
                    .map((city) => DropdownMenuItem(
                          child: Text(city),
                          value: city,
                        ))
                    .toList()
                : [],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(),
            color: kblue,
            child: RaisedButton(
              onPressed: (){
                _db.getMolestation(stateValue, cityValue, chooseyear);
                _db.getMurder(stateValue, cityValue, chooseyear);
                _db.getDrugs(stateValue, cityValue, chooseyear);
                _db.getOther(stateValue, cityValue, chooseyear);
                _db.getRobbery(stateValue, cityValue, chooseyear);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {

                      return crimeRate(molestation: random.nextInt(90),drugs: random.nextInt(90),other: random.nextInt(90),robbery: random.nextInt(90),murder: random.nextInt(70),);
                    },
                  ),
                );
              },
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
