import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid ='';

  getUid(){}

  @override
  void initState(){
    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val){
      setState((){
        this.uid = val.uid;
      });
    }).catchError((e){
      print(e);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepOrangeAccent,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: new Text('HomePage'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('You are now logged in as $uid'),
                SizedBox(
                  height: 15.0,
                ),
                new OutlineButton(
                    borderSide: BorderSide(
                        color: Colors.red,
                        style: BorderStyle.solid,
                        width: 3.0),
                    child: Text('Logout'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context)
                            .pushReplacementNamed('/landinpage');
                      }).catchError((e) {
                        print(e);
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
