import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/login_page_collab.dart';
import 'package:hexcolor/hexcolor.dart';

class ChoosePage extends StatefulWidget{
  const ChoosePage({Key? key}): super(key:key);

  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          color: HexColor('#FFC300'),
          height: 1000.0,
          alignment: Alignment.center,
          child: new Column(
            children: [
              InkWell(
                child: Center(
                  child: Container(
                    height: 500.0,
                    width: 140.0,
                    child: Center(
                      child: ClipOval(
                        child: Icon(Icons.account_circle_rounded, size: 128,), //put your logo here
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2.0,
                            offset: Offset(5.0, 3.0),
                            spreadRadius: 2.0,
                          )
                        ]
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('User Phase'),
                      actions: [
                        TextButton(
                          child: Text('Go to User Login Page'),
                          onPressed: () {
                            //Code for download the image
                            Navigator.push( context, MaterialPageRoute( builder: (context) => LoginPage()), );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              InkWell(
                child:Center(
                  child: Container(
                    height: 140.0,
                    width: 140.0,
                    child: Center(
                      child: ClipOval(
                        child: Icon(Icons.account_balance, size: 128,),
                        // child: Image.asset('assets/images/l1.png'),//Icon(Icons.android_outlined, size: 128,), //put your logo here
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2.0,
                            offset: Offset(5.0, 3.0),
                            spreadRadius: 2.0,
                          )
                        ]
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Collaborator Phase'),
                      actions: [
                        TextButton(
                          child: Text('Go to Collab Login Page'),
                          onPressed: () {
                            //Code for download the image
                            Navigator.push( context, MaterialPageRoute( builder: (context) => LoginPageCollab()), );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}