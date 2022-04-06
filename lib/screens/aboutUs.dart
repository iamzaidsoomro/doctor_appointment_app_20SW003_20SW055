import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const <Widget>[
              Image(
                image: NetworkImage(
                    "https://png.pngtree.com/thumb_back/fh260/back_our/20190620/ourmid/pngtree-medical-flat-simple-green-poster-background-image_161688.jpg"),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Text("App info",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      textBaseline: TextBaseline.alphabetic)),
              SizedBox(height: 15),
              Text(
                  "This app is a solution for booking an appointment with a doctor remotely. This is a secure and modern way of solving this issue. With the help of this app, you can easily see the available doctor on specific dates and time. You can also book an appointment with the doctor and get the appointment confirmation. This app is developed by a team of two students of the Software Engineering Department, MUET. The app is developed by the following members:\n\nZaid Ahmed (20SW003)\nFarheen Qazi (20SW055)",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontFamily: 'Roboto'),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
