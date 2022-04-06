import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppointments extends StatefulWidget {
  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('appointments');
    var name = '';
    var user_appointment_codes = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('appointments')
                .where('user',
                    isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get()
                    .then((value) {
                  user_appointment_codes = value.data()?['appointments'];
                  print(user_appointment_codes);
                });
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              int index = 0;
              return ListView.builder(
                  itemCount: user_appointment_codes.length,
                  itemBuilder: (BuildContext context, index) {
                    db
                        .doc(user_appointment_codes[index])
                        .get()
                        .then((value) async {
                      name = value.data()?['patient'];
                      print(name);
                    });
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text(
                          user_appointment_codes[index],
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          'Appointment ID',
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            db.doc(user_appointment_codes[index]).delete();
                            setState(() {
                              user_appointment_codes.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
