import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
//Facebook provider
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scafflodkey = new GlobalKey<ScaffoldState>();//Using this key shows snakbar evertything etc...
  final formkey = new GlobalKey<FormState>();

  String _email; //i have use underscore here because its a private field
  String _password;

  @override
    void initState() {

    }

    @override
      void dispose() {
        // TODO: implement dispose
        super.dispose();
      }

      void _login(){}
  //Facebook signin
  //FacebookLogin fbLogin = new FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepOrangeAccent,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        key: scafflodkey,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            padding: EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               new TextField(
                    decoration: InputDecoration(hintText: 'Email'),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {_login();
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((FirebaseUser user) {
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
                SizedBox(height: 15.0),
                Text('Don\'t have an account?'),
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text('Sign Up'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                )
              ],
            ),
          )),
        ),
      ),
    ),
    )}
}
