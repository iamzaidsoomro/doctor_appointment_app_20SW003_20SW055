import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/Screens/signup.dart';
import 'package:doctor_appointment/Screens/home.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  String _msg = '';
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    dynamic img;
    if (Theme.of(context).primaryColor == Colors.blue) {
      img = AssetImage('./assets/lightlogo.png');
    } else {
      img = AssetImage('./assets/darklogo.png');
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: img),
          Text('Login',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Theme.of(context).primaryColor)),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.person, color: Theme.of(context).primaryColor),
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
              onChanged: (value) => _email = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.lock, color: Theme.of(context).primaryColor),
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
              onChanged: (value) => _password = value,
            ),
          ),
          Text(
            _msg,
            style: TextStyle(color: Colors.red),
          ),
          OutlinedButton(
            child: Text('Login'),
            onPressed: () async {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _email.trim().toLowerCase(), password: _password)
                  .then((user) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              }).catchError((e) {
                setState(() {
                  _msg = e.message;
                });
                print(e);
              });
            },
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New User?'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text('Sign up',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15))),
            ],
          )
        ],
      ),
    ));
  }
}
