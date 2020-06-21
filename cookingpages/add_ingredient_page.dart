import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/cookingpages/ingredient_page.dart';
//import 'package:login/widgets/custom_textfield.dart';
import 'package:login/widgets/custom_modal_action_button.dart';
//import 'package:login/pages/ingredient_page.dart';

class AddIngredientList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IngredientList();
} 

class IngredientList extends State<AddIngredientList> {
  String input = "";
  TextEditingController mycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  static List<IngredList> ingredlist = new List<IngredList>();

  static List getingredlist(){
    return ingredlist;
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
              "Add new ingredients", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24
              ),
              TextField(
                controller: mycontroller,
                decoration: InputDecoration(hintText: 'Enter ingredient')
                ),
              SizedBox(height: 12),
            SizedBox(
              height: 24
              ),
              CustomModalActionButton(
                onClose: () {
                Navigator.of(context).pop();
          }, onSave: () {
            ingredlist.add(IngredList(mycontroller.text));
            Navigator.pop(context);
            IngredientListHomePage();
          }
          )])
      );
  }
}
class IngredList {
  String ingred;
  IngredList(this.ingred);

}


     