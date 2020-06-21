import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:login/widgets/custom_textfield.dart';
import 'package:login/widgets/custom_modal_action_button.dart';
import 'package:login/cookingpages/recipe_page.dart';

class AddRecipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecipeList();
} 

class RecipeList extends State<AddRecipeList> {
  String input = "";
  TextEditingController mycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  static List<Recipe> recipelist = new List<Recipe>();

  static List getrecipelist(){
    return recipelist;
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
              "Add new steps", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24
              ),
              TextField(
                controller: mycontroller,
                decoration: InputDecoration(hintText: 'Enter steps')
                ),
      
              SizedBox(height: 12),
            SizedBox(
              height: 24
              ),
              CustomModalActionButton(
                onClose: () {
                Navigator.of(context).pop();
          }, onSave: () {
            recipelist.add(Recipe(mycontroller.text));
            RecipeListHomePage();
            Navigator.pop(context);
          }
          )])
      );
  }
}

class Recipe{
  String recipe;
  Recipe(this.recipe);
}


     