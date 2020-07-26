import 'package:flutter/material.dart';
import 'package:login/pages/settings.dart';
// import 'package:login/pages/settings.dart';

class Background extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BackgroundPage();
}

class BackgroundPage extends State<Background> {
  String _selected = 'None';

  String getBackgroundAssetName() {
    return _selected;
  }

  var assetImage1 = new AssetImage('assets/motivational.jpg');
  var assetImage2 = new AssetImage('assets/nature.jpg');
  var assetImage3 = new AssetImage('assets/kakao.jpg');

  var image;

  //String _selected = 'None';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Background choices',
        home: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings()));
                      }),
                  title: Text("Choose Your Background",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.purple,
                )),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    elevation: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Ink(
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          backgroundBlendMode: BlendMode.darken,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage('assets/motivational.jpg'),
                          )),
                      child: ListTile(
                        title: Text(
                          "Motivational Background",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Do not give up, keep on going!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.italic)),
                        onTap: () async {
                          setState(() {
                            image = new Image(image: assetImage1, height: 48.0, width: 48.0,);
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
                Card(
                  elevation: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Ink(
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          backgroundBlendMode: BlendMode.darken,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage('assets/nature.jpg'),
                          )),
                      child: ListTile(
                        title: Text(
                          "Nature Background",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Keep calm and appreciate nature",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.italic)),
                        onTap: () {
                          setState(() {
                            _selected = 'assets/nature.jpg';
                          });
                          Navigator.of(context).pop();
                        },
                      )),
                ),
                Card(
                    elevation: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Ink(
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          backgroundBlendMode: BlendMode.darken,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage('assets/kakao.jpg'),
                          )),
                      child: ListTile(
                        title: Text(
                          "Kakao Background",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Kakao and friends!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.italic)),
                        onTap: () {
                          setState(() {
                            _selected = 'assets/kakao.jpg';
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ))
              ],
            )));
  }
}
