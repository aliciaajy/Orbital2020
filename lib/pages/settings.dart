import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:login/progress_indicator/todolist_progress.dart';
import 'package:login/backgroundpage/background.dart';

class Settings extends StatelessWidget {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Option()));
              }),
          title: new Text('Settings'),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: new ListView(children: <Widget>[
          new ListTile(
            title: new Text('Profile'),
            isThreeLine: true,
            subtitle: new Text('Edit profile'),
            trailing: new Icon(Icons.account_box),
          ),
          new ListTile(
            title: new Text('Password'),
            isThreeLine: true,
            subtitle: new Text('Change password'),
            trailing: new Icon(Icons.lock_outline),
          ),
          new ListTile(
            title: new Text('Background Design'),
            isThreeLine: true,
            subtitle: new Text('Edit background image'),
            trailing: new Icon(
              Icons.format_color_fill,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Background()));
            },
          ),
          new ListTile(
              title: new Text('Progress'),
              isThreeLine: true,
              subtitle: new Text(
                  'Check your percentage of work done and the progress of your lists'),
              trailing: new Icon(Icons.hourglass_empty),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProgressPage()));
              }),
          new ListTile(
              title: new Text('Sign Out'),
              subtitle: new Text('Log out of your account'),
              isThreeLine: true,
              trailing: new Icon(Icons.directions),
              onTap: () async {
                await _firebaseAuth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              }),
        ]));
  }
}
