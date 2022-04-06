import 'package:doctor_appointment/screens/aboutUs.dart';
import 'package:doctor_appointment/screens/appointment.dart';
import 'package:doctor_appointment/screens/doctors.dart';
import 'package:doctor_appointment/screens/myAppointments.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/Screens/profile.dart';
import 'package:doctor_appointment/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    final user = FirebaseAuth.instance.currentUser;
    dynamic email = '';
    dynamic name = '';
    dynamic picture = '';
    if (user != null) {
      email = user.email;
      name = user.displayName;
      picture = user.photoURL;
    }
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(email,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).secondaryHeaderColor)),
              accountName: Text(name.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).secondaryHeaderColor)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(picture),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT78sRUReZDjXJIf-ZbaRGupqG603oPIdMx_Ea8YLDyVU_ohoTBymwJYsIOLx5iHlAiF7Y&usqp=CAU'),
                      fit: BoxFit.cover,
                      scale: 1.0)),
            ),
            ListTile(
              leading:
                  Icon(Icons.person, color: Theme.of(context).primaryColor),
              title: Text('Profile',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).primaryColor),
              title: Text('About us',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text('Log Out', style: TextStyle(color: Colors.redAccent)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
          title: Text('Home',
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          actions: [CircleAvatar(backgroundImage: NetworkImage(picture))],
          iconTheme: Theme.of(context).iconTheme),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text('Hi, $name',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            Image(image: AssetImage('./assets/HomePageCover.png')),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.add, color: Theme.of(context).primaryColor),
                title: Text('New Appointment',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Appointment()));
                },
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.medical_services,
                    color: Theme.of(context).primaryColor),
                title: Text('View Doctors',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Doctors()));
                },
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.business_center,
                    color: Theme.of(context).primaryColor),
                title: Text('View Appointments',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAppointments()));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
