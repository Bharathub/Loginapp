import 'package:flutter/material.dart';

//import 'services/usermanagement.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

class MyApp extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        home: new SignupPage(),
        routes: <String,WidgetBuilder>{
          '/homepage': (BuildContext context)=> MyApp(),
          'landinpage': (BuildContext context) => SignupPage(),
        }
      );
    }
}



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _name;
  String _email;
  String _password;
  String _confirmPassword;
  String _phoneNo;
  String _smsCode;
  String _verificationId;
  
  Future<void> verifyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve =(String verId){
      this._phoneNo = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      this._verificationId = verId;
      smsCodeDialog(context).then((value){
        print('Signed in');
      });

    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception){
      print('${exception.message}');
    };
    
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this._phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed
    );
  }

  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text('Enter the OTP'),
          content: TextField(
            onChanged: (value){
              this._smsCode= value;
            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            new FlatButton(
              child: Text('Done'),
              onPressed: (){
                FirebaseAuth.instance.currentUser().then((user){
                  if (user != null){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  }else{
                    Navigator.of(context).pop();
                    signIn();
                  }
                });
              },
            )
          ],
        );
      }
    );
  }

  signIn(){
    FirebaseAuth.instance
    .signInWithPhoneNumber(verificationId: _verificationId, smsCode: _smsCode)
    .then((user){
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e){
      print(e);
    });
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
          title: Text('Sign Up'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(hintText: 'Full Name*'),
                      onChanged: (value) {
                        //setState(() {
                          _name = value;
                        //});
                      }),
                  TextField(
                      decoration:
                          InputDecoration(hintText: '(country code) Mobile No*'),
                      onChanged: (value) {
                        _phoneNo = value;

                        //setState(() {
                        //});
                      }),
                  TextField(
                      decoration: InputDecoration(hintText: 'Email*'),
                      onChanged: (value) {
                        //setState(() {
                          _email = value;
                        //});
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                      decoration: InputDecoration(hintText: 'Password*'),
                      onChanged: (value) {
                        //setState(() {
                          _password = value;
                        //});
                      }),
                  TextField(
                      decoration: InputDecoration(hintText: 'Confirm Password*'),
                      onChanged: (value) {
                        //setState(() {
                          _confirmPassword = value;
                        //});
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: verifyPhone,
                    //{
                      //Navigator.of(context).pushNamed('/otpPage');
                      //FirebaseAuth.instance
                         // .createUserWithEmailAndPassword(
                              //email: _email,
                             // password: _password,
                             // confirmpassword: _confirmPassword)
                         // .then((signedInUser) {
                        //UserManagement().storeNewUser(signedInUser, context);
                     // }).catchError((e) {
                      //  print(e);
                     // });
                    //},
                  ),
                ],
              )),
        )),
      ),
    );
  }
}
