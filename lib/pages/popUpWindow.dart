import 'package:flutter/material.dart';
class PopUp extends StatefulWidget {
  final Map<String, String> info;

  const PopUp({Key? key, required Map<String,String> this.info}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.centerLeft,

      child: Container(
        color: Colors.white,
        width: 300,
        height: 300,
        child: GridView.count(
          primary: false,
          padding:  EdgeInsets.all(50),
          mainAxisSpacing: 10,

          crossAxisSpacing: 0,
          childAspectRatio: 3/2,
          crossAxisCount: 2,
          children: <Widget>[
            Text("Name"),
            Text(widget.info['Name'].toString()),
            Text("Area"),
            Text(widget.info['Area'].toString()),
            Text("Price"),
            Text(widget.info['Price'].toString()),
            Text("Phone Number"),
            Text(widget.info['Phone'].toString())
          ],
        ),


      ),
    );
  }
}
