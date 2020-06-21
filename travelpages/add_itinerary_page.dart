import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:login/widgets/custom_textfield.dart';
import 'package:login/widgets/custom_modal_action_button.dart';
import 'package:login/travelpages/itinerary_page.dart';

class AddItineraryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ItineraryList();
} 

class ItineraryList extends State<AddItineraryList> {
  String input = "";
  TextEditingController mycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  static List<Itinerary> itinerarylist = new List<Itinerary>();

  static List getitinerarylist(){
    return itinerarylist;
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
              "Add new destination", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24
              ),
              TextField(
                controller: mycontroller,
                decoration: InputDecoration(hintText: 'Enter destination')
                ),
      
              SizedBox(height: 12),
            SizedBox(
              height: 24
              ),
              CustomModalActionButton(
                onClose: () {
                Navigator.of(context).pop();
          }, onSave: () {
            itinerarylist.add(Itinerary(mycontroller.text));
            ItineraryListHomePage();
            Navigator.pop(context);
          }
          )])
      );
  }
}

class Itinerary{
  String place;
  Itinerary(this.place);
}


     