import 'package:flutter/material.dart';

//import'package:flutter/material.dart';

//import 'package:firebase_auth/firebase_auth.dart';

//import 'dart:async';

import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';
//import 'otpPage.dart';


void main() => runApp(new MyApp()); 
 
 class MyApp extends StatelessWidget{
   @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: LoginPage(),
         routes: <String,WidgetBuilder>{
           '/landinpage': (BuildContext context) => new MyApp(),
           '/signup': (BuildContext context) => new SignupPage(),
           '/homepage': (BuildContext context) => new HomePage(),
           //'/otpPage': (BuildContext context) => new OtpPage(),
         },
       );
     }

 }