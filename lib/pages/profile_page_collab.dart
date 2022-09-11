
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/login_page_collab.dart';
import 'package:flutter_login_ui/pages/registration_page_collab.dart';
import 'package:flutter_login_ui/pages/splash_screen.dart';
import 'package:flutter_login_ui/pages/widgets/header_widget.dart';

import '../common/theme_helper.dart';
import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class ProfilePageCollab extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageCollabState();
  }
}

class _ProfilePageCollabState extends State<ProfilePageCollab>{

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> users=FirebaseFirestore.instance.collection("Collaborator Info").snapshots();
    final user= FirebaseAuth.instance.currentUser!;

    var orgname="";
    var store_email="";
    var number="";
    var location="";

    // access email of user, which is also the name of the document giving us access to the users data
    final docRef=FirebaseFirestore.instance.collection("Collaborator Info").doc(user.email!);
    docRef.get().then(
            (DocumentSnapshot doc){
          var email=doc.data() as Map<String,dynamic>;
          orgname= email["Org Name"];

          store_email=email["Org Email"];
          number= email["Mobile Number"];
          location= email["Location"];



        },
        onError: (e) => print("Error getting document: $e")
    );


    return Scaffold(body:StreamBuilder<QuerySnapshot>(
    stream: users,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("something went wrong");
      }
      else if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      else {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("PARK NOW",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageCollab()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPageCollab()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                      ],
                    ),
                    child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                  ),
                  SizedBox(height: 20,),
                  Text(orgname, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                 // Text('Shopping Mall', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Location"),
                                          subtitle: Text(location),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle: Text(store_email),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text(number),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text("About Me"),
                                          subtitle: Text(
                                              "This is a about me link and you can khow about me in this section."),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration('Parking Name', 'Enter your parking\'s name'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration('Number of Parking Spots', 'Enter your parking\'s total number of spots'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration('Location', 'Enter your parking\'s location'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration('Area', 'Enter your parking\'s area'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration('Special Needs', 'Enter specific needs (if any)'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration('Charging Station Equipped', 'Enter yes if you have an equipped charging station (no if not)'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 20.0),
                                        Container(
                                          child: TextFormField(
                                            decoration: ThemeHelper().textInputDecoration("Operating Hours", "Enter your operating hours"),
                                            keyboardType: TextInputType.emailAddress,
                                            validator: (val) {
                                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                                return "Enter valid dates";
                                              }
                                              return null;
                                            },
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                        SizedBox(height: 20.0),
                                        Container(
                                          child: TextFormField(
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
                                            obscureText: true,
                                            decoration: ThemeHelper().textInputDecoration(
                                                "Price List", "Enter your price list"),
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "Please enter a valid price list";
                                              }
                                              return null;
                                            },
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

    }));
  }
}