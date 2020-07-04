import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:login/pages/type_of_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPage({Key key}) : super(key: key);
  State createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  bool showProgress = false;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  Future signUp(email, password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext buildcontext) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.blue,
        body: new Stack(fit: StackFit.expand, children: <Widget>[
          new Image(
            image: new AssetImage('assets/todolist.jpg'),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 30),
                        color: Colors.cyanAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.cyanAccent),
                      ),
                    ]),
                    new Image(
                      image: new AssetImage('assets/elogo!.png'),
                      width: 200,
                      height: 200,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Email*',
                          hintText: "Enter your email",
                          hintStyle:
                              new TextStyle(color: Colors.grey, fontSize: 15.0),
                          labelStyle: new TextStyle(
                              color: Colors.cyanAccent, fontSize: 20.0)),
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Password*',
                          hintText: "Enter your password",
                          hintStyle:
                              new TextStyle(color: Colors.grey, fontSize: 15.0),
                          labelStyle: new TextStyle(
                              color: Colors.cyanAccent, fontSize: 20.0)),
                      controller: pwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Confirm Password*',
                          hintText: "Enter your password",
                          hintStyle:
                              new TextStyle(color: Colors.grey, fontSize: 15.0),
                          labelStyle: new TextStyle(
                              color: Colors.cyanAccent, fontSize: 20.0)),
                      controller: confirmPwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                    new MaterialButton(
                      height: 40.0,
                      minWidth: 200.0,
                      color: Colors.cyan,
                      textColor: Colors.white,
                      child: new Text("Sign Up"),
                      onPressed: () {
                        signup();
                      },
                      //   setState(() {
                      //     showProgress = true;
                      //   });
                      //   if (_registerFormKey.currentState.validate()) {
                      //     if (pwdInputController.text ==
                      //         confirmPwdInputController.text)
                      //       try {
                      //         final newuser =
                      //             await _auth.createUserWithEmailAndPassword(
                      //                 email: emailInputController.text,
                      //                 password: pwdInputController.text);
                      //         if (newuser != null) {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => LoginPage()),
                      //           );
                      //           setState(() {
                      //             showProgress = false;
                      //           });
                      //         }
                      //       } catch (e) {
                      //         print(e);
                      //       }
                      //   }
                      // },
                      splashColor: Colors.redAccent,
                    )
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  void signup() {
    if (_registerFormKey.currentState.validate()) {
      if (pwdInputController.text == confirmPwdInputController.text) {
        _auth
            .createUserWithEmailAndPassword(
                email: emailInputController.text,
                password: pwdInputController.text)
            .then((res) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }).catchError((err) {
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
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Password do not match. Please try again"),
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
      }
    }
  }
}
