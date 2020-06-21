import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:login/widgets/custom_textfield.dart';
import 'package:login/widgets/custom_modal_action_button.dart';
import 'package:login/travelpages/packing_page.dart';

class AddPackingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PackingList();
} 

class PackingList extends State<AddPackingList> {
  String input = "";
  TextEditingController mycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  static List<Packing> packinglist = new List<Packing>();

  static List getpackinglist(){
    return packinglist;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Add new items", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24
              ),
              TextField(
                controller: mycontroller,
                decoration: InputDecoration(hintText: 'Enter item')
                ),
      
              SizedBox(height: 12),
            SizedBox(
              height: 24
              ),
              CustomModalActionButton(
                onClose: () {
                Navigator.of(context).pop();
          }, onSave: () {
            packinglist.add(Packing(mycontroller.text));
            PackingListHomePage();
            Navigator.pop(context);
          }
          )])
      );
  }
}

class Packing{
  String item;
  Packing(this.item);
}


     