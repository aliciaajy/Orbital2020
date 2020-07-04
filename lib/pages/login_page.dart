import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  String email, password;
  @override
  Widget build(BuildContext buildcontext) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage('assets/todolist.jpg'),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage('assets/elogo!.png'),
                width: 200,
                height: 200,
              ),
              new Form(
                  child: new Theme(
                      data: new ThemeData(
                          brightness: Brightness.dark,
                          primarySwatch: Colors.cyan,
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                  color: Colors.cyanAccent, fontSize: 20.0))),
                      child: new Container(
                          padding: const EdgeInsets.all(40.0),
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: 'Enter Email:',
                                    hintText: 'Enter Email',
                                    hintStyle: new TextStyle(
                                        color: Colors.grey, fontSize: 15.0),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value; // get value from TextField
                                  },
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: 'Enter Password:',
                                    hintText: 'Enter Password',
                                    hintStyle: new TextStyle(
                                        color: Colors.grey, fontSize: 15.0),
                                  ),
                                  onChanged: (value) {
                                    password =
                                        value; // get value from TextField
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                new MaterialButton(
                                  height: 40.0,
                                  minWidth: 400.0,
                                  color: Colors.cyan,
                                  textColor: Colors.white,
                                  child: new Text("Login"),
                                  onPressed: () async {
                                    signin();
                                  },
                                  splashColor: Colors.redAccent,
                                  // onPressed: () => {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Option()),
                                  //   )
                                  // },
                                ),
                                new MaterialButton(
                                  height: 40.0,
                                  minWidth: 400.0,
                                  color: Colors.cyan,
                                  textColor: Colors.white,
                                  child: new Text("Sign Up"),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()),
                                    )
                                  },
                                  splashColor: Colors.redAccent,
                                )
                              ]))))
            ],
          ),
        ],
      ),
    );
  }

  void signin() {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Option()),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
