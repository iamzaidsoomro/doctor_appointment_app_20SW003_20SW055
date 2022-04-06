import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/Screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var name = "";
    var _email = "";
    var _password = "";
    dynamic _picture = "";
    var _msg = '';
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 180,
        ),
        Text("Sign Up",
            style:
                TextStyle(fontSize: 30, color: Theme.of(context).primaryColor)),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.person, color: Theme.of(context).primaryColor),
              labelText: 'Name',
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
            onChanged: (value) => name = value,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.mail, color: Theme.of(context).primaryColor),
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
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.image_search_outlined,
                  color: Theme.of(context).primaryColor),
              labelText: 'Image Url',
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
            onChanged: (value) => _picture = value,
          ),
        ),
        Text(_msg, style: TextStyle(color: Colors.red)),
        SizedBox(
          height: 15,
        ),
        OutlinedButton(
          child: Text('Create Account'),
          onPressed: () async {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email.trim().toLowerCase(),
                    password: _password.trim())
                .then((user) {
              if (_picture == "") {
                _picture =
                    "https://asota.umobile.edu/wp-content/uploads/2021/08/Person-icon.jpeg";
              }
              user.user?.updateDisplayName(name);
              user.user?.updatePhotoURL(_picture);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.user?.uid)
                  .set({
                'name': name,
                'email': _email,
                'photoURL': _picture,
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Login',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15))),
            ]),
      ],
    )));
  }
}
