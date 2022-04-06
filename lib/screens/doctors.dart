import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/screens/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctors extends StatelessWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Doctors',
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color)),
      body: Center(
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: <Widget>[
            docCard(context, 'Dr Rizwan Alam', 'male', 'MBBS, MCPS',
                ['sat', 'sun'], 'wQr7rTtq6AzNmqXr0iLe'),
            docCard(context, 'Dr Rukhsana', 'female', 'MBBS, FCPS',
                ['Fri', 'sat', 'sun'], 'E07oGI6f6Mvpy5ckciTW'),
            docCard(context, 'Dr Samar Zaki', 'female', 'MBBS, FCPS',
                ['Mon', 'Tue', 'Wed', 'Thu'], 'r9d5trnvgzWvlDNeOsco'),
            docCard(context, 'Dr Ahmed Iqbal', 'male', 'MBBS, MCPS',
                ['Mon', 'Tue'], 'S1r4gqoapip9Qu4tD6T7'),
            docCard(context, 'Dr Tabinda Ashfaq', 'female', 'MBBS, MCPS, MRCGP',
                ['Wed', 'Thu', 'Fri', 'Sat'], 'GdIun35eSbVPw7XfIscX'),
            docCard(
                context,
                'Dr Ummarah Farukh',
                'female',
                'MBBS, MCPS',
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                'WaMcmg6BwgtDWEaKAzAF'),
          ])),
    );
  }

  Widget docCard(
      BuildContext context, name, gender, qualification, days, docId) {
    var img, bg;
    if (gender.toLowerCase() == 'male') {
      img = AssetImage('./assets/maledoctor.png');
      bg = Colors.blueAccent;
    } else {
      img = AssetImage('./assets/femaledoctor.png');
      bg = Colors.pinkAccent;
    }
    return Card(
        child: InkWell(
      onTap: () {
        final db = FirebaseFirestore.instance;
        db.collection('doctors').doc(docId).get().then((value) {
          if (value.data() != null) {
            print(value.data().toString());
          }
        }).catchError((e) => print(e.toString()));
      },
      child: Column(
        children: [
          CircleAvatar(
            foregroundImage: img,
            backgroundColor: bg,
            radius: 50,
          ),
          SizedBox(height: 10),
          Text(name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor)),
          SizedBox(height: 10),
          Text(qualification,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          Text(days[0] + '-' + days[days.length - 1],
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
        ],
      ),
    ));
  }
}
