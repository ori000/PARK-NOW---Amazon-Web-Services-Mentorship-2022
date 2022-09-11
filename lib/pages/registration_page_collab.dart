// firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';

// flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_test/flutter_test.dart';

// page imports
import 'package:flutter_login_ui/pages/profile_page_collab.dart';
import 'RegistrationMap.dart';
import 'package:flutter_login_ui/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';




class RegistrationPageCollab extends  StatefulWidget{
  static var txt_longitude= TextEditingController();
  static var txt_latitude= TextEditingController();

  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageStateCollab();
  }
}

class _RegistrationPageStateCollab extends State<RegistrationPageCollab>{

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  var orgname='';
  var orgemail='';
  var location='';
  var price='';
  var availability='';
  var hours='';
  var number='';
  var password='';
  String longitude="";
  String latitude="";




  @override
  Widget build(BuildContext context) {
    CollectionReference users= FirebaseFirestore.instance.collection("Collaborator Info");


    Future signUp() async {
      // if form has been filled
      if (_formKey.currentState!.validate()) {
        try {
          // create user in firebase authentication
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: orgemail.trim(), password: password.trim());
          print("User added to firebase authentication");
          // add entries to firestore database
          users.doc(orgemail)
              .set( <String,dynamic>{
                'Org Name': orgname,
            'Org Email': orgemail,
            'Longitude': longitude,
            'Latitude': latitude,
            "Mobile Number": number,
            "Password": password,
            "Hours": hours,
            "Availability": availability,
            "Price": price,

          })
              .then((value) => print("User Added to firestore database"))
              .catchError((error) =>
              print("Failed to add user to firestore database: $error"));


          // go to next page
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePageCollab()
              ),
                  (Route<dynamic> route) => false
          );
        }
        on FirebaseAuthException catch(e){
          print("firebase auth error");
          Utils.showSnackBar(e.message);
          print(e);

        }
      }
    }



        return Scaffold(backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              orgname=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Org. Name', 'Enter your organization\'s name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        /*
                          Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondPage()),
                         */
                        Container(

                          child: TextFormField(
                            controller: RegistrationPageCollab.txt_longitude,
                            onChanged: (value){
                              longitude=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Longitude', 'Enter longitude'),


                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        Container(

                          child: TextFormField(
                            controller: RegistrationPageCollab.txt_latitude,
                            onChanged: (value){
                              latitude=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Latitude', 'Enter latitude'),


                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Location".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Scaffold(body:RegistrationMap())));
                          }



                          ),
                        ),
                        /*
                        Container(

                          child: TextFormField(
                            onChanged: (value){
                              location=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Location', 'Enter your organization\'s location'),


                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        */
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              orgemail=value;
                            },
                            decoration: ThemeHelper().textInputDecoration("E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              number=value;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number",
                                "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              password=value;
                            },
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password(min 6 characters)"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              price=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Prices', 'Enter your organization\'s spot price per our'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              availability=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Available Spots', 'Enter your organization\'s parking\'s available spots'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value){
                              hours=value;
                            },
                            decoration: ThemeHelper().textInputDecoration('Operating Hours', 'Enter your organization\'s parking\'s operating hours per day'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: signUp,



                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text("Or create account using social media",  style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 35,
                                color: HexColor("#EC2D2F"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Google Plus","You tap on GooglePlus social icon.",context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(width: 30.0,),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter, size: 23,
                                  color: HexColor("#FFFFFF"),),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Twitter","You tap on Twitter social icon.",context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 35,
                                color: HexColor("#3E529C"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Facebook",
                                          "You tap on Facebook social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );}
  }



