import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class Appointment extends StatefulWidget {
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _items = [];
    final db = FirebaseFirestore.instance;
    var docs = [
      'E07oGI6f6Mvpy5ckciTW',
      'GdIun35eSbVPw7XfIscX',
      'S1r4gqoapip9Qu4tD6T7',
      'WaMcmg6BwgtDWEaKAzAF',
      'r9d5trnvgzWvlDNeOsco',
      'wQr7rTtq6AzNmqXr0iLe'
    ];
    for (String i in docs) {
      db.collection('doctors').doc(i).get().then((value) {
        if (value.data() != null) {
          _items.add({
            'value': value.data()?['name'],
            'label': value.data()?['name'],
            'id': i
          });
          print(value.data().toString());
        }
      }).catchError((e) => print(e.toString()));
    }
    final List<Map<String, dynamic>> _days = [
      {'value': '', 'label': ''}
    ];
    dynamic _msg = '';
    dynamic pname = null;
    dynamic description = null;
    dynamic _selected_doc = null;
    dynamic _selected_day = null;
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment',
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Text(
                "Patient Details",
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,
                        color: Theme.of(context).primaryColor),
                    labelText: 'Patient Name',
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
                  onChanged: (value) {
                    pname = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description,
                          color: Theme.of(context).primaryColor),
                      labelText: 'Disease Description',
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
                    onChanged: (value) => description = value),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  items: _items,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.medical_services,
                        color: Theme.of(context).primaryColor),
                    labelText: 'Select Doctor',
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    focusColor: Theme.of(context).primaryColor,
                  ),
                  onChanged: (val) {
                    _selected_doc = val;
                    for (int i = 0; i < _items.length; i++) {
                      if (_items[i]['label'] == val) {
                        _selected_doc = _items[i]['id'];
                      }
                    }
                    db
                        .collection('doctors')
                        .doc(_selected_doc)
                        .get()
                        .then((value) {
                      if (value.data() != null) {
                        _days.clear();
                        for (int i = 0; i < value.data()?['days'].length; i++) {
                          _days.add({
                            'value': value.data()?['days'][i],
                            'label': value.data()?['days'][i]
                          });
                        }
                        print(_days);
                      }
                    }).catchError((e) => setState(() {
                              _msg = e.message;
                            }));
                  },
                  onSaved: (val) => print(val),
                  onFieldSubmitted: (val) => _selected_doc = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  items: _days,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today,
                        color: Theme.of(context).primaryColor),
                    labelText: 'Select Day',
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    focusColor: Theme.of(context).primaryColor,
                  ),
                  onChanged: (val) => _selected_day = val,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(_msg, style: TextStyle(color: Colors.red)),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                child: Text('Submit'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  var uid = user?.uid;
                  db.collection('users').doc(uid).get().then((value) {
                    if (value.data() != null) {
                      if (pname != null &&
                          description != null &&
                          _selected_doc != null &&
                          _selected_day != null) {
                        db.collection('appointments').add({
                          'patient': pname,
                          'patient_id': uid,
                          'doctor': _selected_doc,
                          'day': _selected_day,
                          'disease': description,
                          'status': 'pending',
                          'timestamp': FieldValue.serverTimestamp()
                        }).then((value) {
                          print(value.id);
                          db.collection('users').doc(uid).update({
                            'appointments': FieldValue.arrayUnion([value.id])
                          }).then((value) {
                            print('success');
                          }).catchError((e) => setState(() {
                                _msg = e.message;
                              }));
                        }).catchError((e) => setState(() {
                              _msg = e.message;
                            }));
                      }
                    } else {
                      print('Fields can\'t be empty');
                    }
                  }).catchError((e) => print(e.toString()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
