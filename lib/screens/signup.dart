import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map/screens/login.dart';
import 'package:map/services/auth.dart';
import 'package:map/utils/constant.dart';
import 'package:map/models/user.dart';
import 'package:map/services/db.dart';
import 'package:provider/provider.dart';
import 'package:map/screens/options.dart';


class signUpScreen extends StatefulWidget {
  @override
  _signUpScreenState createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;



  String name, email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> registerUser() {
      var user=Provider.of<User>(context);
      DatabaseService _db =DatabaseService();
      return _db.addUser(
          name: name,
          uid: user.uid,
         ).then((value) async {
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        prefs.setString('uid', widget.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomepage()),
        );
      }).catchError(
            (error) => print("Some error occured while registering"),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 17,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(color: kblue),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    decoration: decoration,
                    keyboardType: TextInputType.text,
                    validator: (val) => val.isEmpty ? 'Enter name' : null,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    decoration: decoration.copyWith(
                        hintText: "Email", labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    decoration: decoration.copyWith(
                        hintText: "Password", labelText: "Password"),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(),
                    child: RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          registerUser();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyHomepage();
                              },
                            ),
                          );
                          if (result == 'email') {
                            setState(() {
                              error='The account already exists for that mail.\nTry different email account or use Login page.';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "The account already exists for that mail.\nTry different email account or use Login page.")));
                          } else if (result == null) {
                            setState(() {
                              error='Some thing went wrong try again';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(

                                content: Text(
                                    "Some thing went wrong try again")));
                          } else {
                            registerUser();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyHomepage();
                                },
                              ),
                            );
                          }
                        }else{
                          setState(() {
                            error='Fill all the fields and a strong password';
                          });
                          print('hi');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Fill all the fields and a strong password")));
                        }
                      },
                      color: kblue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
