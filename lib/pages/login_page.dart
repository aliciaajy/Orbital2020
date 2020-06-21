import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/pages/type_of_list.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
   
  @override
  Widget build(BuildContext buildcontext){
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage('assets/todolist.jpg'),
            fit: BoxFit.cover,
            color :Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              new Image(
                image: new AssetImage('assets/elogo!.png'),
                 width: 500,
                 height: 125,
             ),
             new Form(
               child: new Theme(
                 data: new ThemeData(
                   brightness: Brightness.dark,
                   primarySwatch: Colors.cyan, 
                   inputDecorationTheme: new InputDecorationTheme(
                     labelStyle: new TextStyle(
                       color: Colors.cyanAccent, fontSize:20.0
                     )
                   )),

                 child: new Container(
                   padding: const EdgeInsets.all(40.0),
                   child: new Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                        new TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Enter Email:',
                     ),
                     keyboardType:TextInputType.emailAddress,
                     ),
                     new TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Enter Password:',
                     ),
                     keyboardType:TextInputType.text,
                     obscureText: true,
                     ),
                     new Padding(
                       padding:const EdgeInsets.only(top: 20.0),
                       ),
                       new MaterialButton(
                         height: 40.0,
                         minWidth: 100.0,
                         color: Colors.cyan,
                         textColor: Colors.white,
                         child: new Text("Login"),
                         onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Option()),
                            )
                         },
                         splashColor: Colors.redAccent,
                       )
                     ],
                   ),
                 ),
               )
           
             )
            ],)
        ],
      ),
    );
  }
}