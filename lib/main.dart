import 'package:flutter/material.dart';
import 'package:doctor_appointment/Screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blue,
            secondaryHeaderColor: Colors.white,
            accentColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Montserrat',
            iconTheme: IconThemeData(color: Colors.white)),
        darkTheme: ThemeData(
            accentColor: Colors.white,
            secondaryHeaderColor: Colors.lightBlueAccent,
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlueAccent,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
        home: LoginPage());
  }
}
